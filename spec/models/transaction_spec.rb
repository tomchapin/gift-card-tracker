require 'rails_helper'

RSpec.describe Transaction, type: :model do

  let(:card_issuer) { FactoryGirl.create(:card_issuer) }
  let(:gift_card) { FactoryGirl.create(:gift_card, card_issuer: card_issuer) }

  describe 'validations' do

    it { is_expected.to monetize(:amount_cents) }

    it 'rejects the transaction if the amount would cause the gift card to go negative' do
      gift_card.transactions.create(amount: 100)
      gift_card.transactions.create(amount: 150)

      expect { gift_card.transactions.create!(amount: -300) }.to raise_exception(ActiveRecord::RecordInvalid)
    end

  end

  describe 'default scope' do
    let!(:transaction_one) { FactoryGirl.create(:transaction, gift_card: gift_card) }
    let!(:transaction_two) { FactoryGirl.create(:transaction, gift_card: gift_card) }

    it 'orders by ascending created_at' do
      expect(Transaction.all).to eq [transaction_one, transaction_two]
    end
  end

  it 'automatically tallies and updates the balance on the gift card when it saves' do
    expect {
      gift_card.transactions.create(amount: 150)
      gift_card.transactions.create(amount: 200)
    }.to change { gift_card.balance.to_i }.from(0).to(350)
  end

end
