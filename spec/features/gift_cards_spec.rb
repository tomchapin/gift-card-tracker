feature 'Gift Cards' do

  let!(:card_issuer_one) { CardIssuer.create!(name: 'Target') }
  let!(:card_issuer_two) { CardIssuer.create!(name: 'Best Buy') }

  scenario 'Attempting to add an invalid gift card' do
    visit new_gift_card_path

    # Click save without filling in anything
    click_button 'Save Gift Card Info'

    # There should be errors about the fields being blank
    expect(page).to have_content('Please review the problems below:')
    expect(page).to have_content("can't be blank")

    # Select just the card issuer and try again
    select 'Target', from: 'gift_card_card_issuer_id'
    click_button 'Save Gift Card Info'

    # There should be errors about the card being blank
    expect(page).to have_content('Please review the problems below:')
    expect(page).to have_content("can't be blank")

    # Select "Target" as the card issuer in the drop-down menu
    select 'Target', from: 'gift_card_card_issuer_id'

    # Enter a malformed credit card number that won't pass a Visa check
    fill_in 'gift_card_card_number', with: '3432 3289 7423 2987'

    # Save the card
    click_button 'Save Gift Card Info'

    # There should be errors about the card number being invalid
    expect(page).to have_content('Please review the problems below:')
    expect(page).to have_content("must be a valid credit card number")
  end

  scenario 'Adding a valid gift card' do
    visit new_gift_card_path

    # Select "Target" as the card issuer in the drop-down menu
    select 'Target', from: 'gift_card_card_issuer_id'

    # Enter a fake credit card number that should pass a Visa check
    fill_in 'gift_card_card_number', with: '4111111111111111'

    # Save the card
    click_button 'Save Gift Card Info'

    # Make sure that the card was created corrected
    expect(page).to have_content('Gift card was successfully created.')
    expect(page).to have_content('Target')
    expect(page).to have_content('4111111111111111')
    expect(page).to have_content('Current Balance	$0.00')

    # Make sure that it was added to the listing on the home page
    visit root_path
    expect(page).to have_content('Target 4111111111111111 $0.00')
  end

  context 'With an existing gift card already in the system' do
    let!(:gift_card) {
      GiftCard.create!(
          card_issuer: card_issuer_one,
          card_number: '4111111111111111'
      )
    }

    scenario 'Editing an existing card' do
      visit edit_gift_card_path(gift_card)

      # Select "Best Buy" as the card issuer in the drop-down menu
      select 'Best Buy', from: 'gift_card_card_issuer_id'

      # Enter a fake credit card number that should pass a Visa check
      fill_in 'gift_card_card_number', with: '4485160902935350'

      # Save the card
      click_button 'Save Gift Card Info'

      expect(page).to have_content('Gift card was successfully updated.')
    end

    scenario 'Attempting to add invalid information to an existing card' do
      visit edit_gift_card_path(gift_card)

      # Enter an invalid credit card number
      fill_in 'gift_card_card_number', with: '1234'

      # Save the card
      click_button 'Save Gift Card Info'

      # There should be errors about the card number being invalid
      expect(page).to have_content('Please review the problems below:')
      expect(page).to have_content("must be a valid credit card number")
    end

    scenario 'Adding transactions to an existing gift card' do
      visit gift_card_path(gift_card)

      # Make sure all of the gift card information is displayed
      expect(page).to have_content('Target')
      expect(page).to have_content('4111111111111111')
      expect(page).to have_content('Current Balance	$0.00')

      # Add a $100.00 transaction, and make sure that the balance was updated correctly
      fill_in 'transaction_amount', with: '100.00'
      click_button 'Log Transaction'
      expect(page).to have_content('Transaction was successfully created.')
      expect(page).to have_content('Current Balance	$100.00')

      # Add a second transaction for $150.00, and make sure that the balance was updated correctly
      fill_in 'transaction_amount', with: '150.00'
      click_button 'Log Transaction'
      expect(page).to have_content('Transaction was successfully created.')
      expect(page).to have_content('Current Balance	$250.00')

      # Attempt to enter an amount that would make the card go negative, and make sure that it is rejected
      fill_in 'transaction_amount', with: '-300.00'
      click_button 'Log Transaction'
      expect(page).to have_content('Transaction would cause gift card balance to go negative!')
      expect(page).to have_content('Current Balance	$250.00')
    end

    scenario 'Deleting an existing gift card' do
      # Add a couple of transactions to the gift card
      3.times { gift_card.transactions << Transaction.create(amount: 150, gift_card: gift_card) }

      # Visit the Manage Gift Cards page
      visit root_path

      # Make sure that the card is listed with the right information
      expect(page).to have_content('Target 4111111111111111 $450.00')

      # Remove the card
      click_link 'Remove Card'

      # Make sure the gift card is no longer displayed
      expect(page).to have_content('Gift card was successfully destroyed.')
      expect(page).to have_no_content('4111111111111111')

      # Make sure that the data is gone
      expect(GiftCard.count).to eq 0
      expect(Transaction.count).to eq 0
    end
  end

end
