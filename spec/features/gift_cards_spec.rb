feature 'Gift Cards' do

  let!(:card_issuer) { CardIssuer.create!(name: 'Target') }

  scenario 'Adding a new gift card' do
    visit root_path

    click_link 'New Gift Card'

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

  scenario 'Adding transactions to a gift card' do
    gift_card = GiftCard.create!(
        card_issuer: card_issuer,
        card_number: '4111111111111111'
    )

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

end
