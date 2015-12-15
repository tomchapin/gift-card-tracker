require 'rails_helper'

RSpec.describe GiftCard, type: :model do

  let(:card_issuer) { FactoryGirl.create(:card_issuer) }
  let(:gift_card) { FactoryGirl.create(:gift_card, card_issuer: card_issuer) }

  describe 'validations' do

    it { is_expected.to validate_presence_of(:card_issuer) }

    it { is_expected.to monetize(:balance_cents) }

    describe 'credit card validation' do
      it 'rejects the card when the card number is a string' do
        gift_card.card_number = 'invalid string'

        expect(gift_card.valid?).to be false
      end

      it 'rejects the card when the card number is less than 16 characters' do
        gift_card.card_number = '1'

        expect(gift_card.valid?).to be false
      end

      it 'rejects the card when the card number is 16 characters without matching a specific card brand format' do
        gift_card.card_number = '1234123412341234'

        expect(gift_card.valid?).to be false
      end

      it 'accepts the visa format' do
        gift_card.card_number = '4111111111111111'

        expect(gift_card.valid?).to be true
      end
    end

  end

  describe 'default scope' do
    let!(:gift_card_one) { FactoryGirl.create(:gift_card) }
    let!(:gift_card_two) { FactoryGirl.create(:gift_card) }

    it 'orders by ascending created_at' do
      expect(GiftCard.all).to eq [gift_card_one, gift_card_two]
    end
  end

  it 'destroys all associated transactions when it is destroyed' do
    3.times { gift_card.transactions << FactoryGirl.create(:transaction, gift_card: gift_card) }

    expect { gift_card.destroy }.to change { Transaction.all.reload.count }.from(3).to(0)
  end


end
