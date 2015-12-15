FactoryGirl.define do
  factory :gift_card do
    card_number { CreditCardValidations::Factory.random(:visa) }
    card_issuer { create(:card_issuer) }
  end
end
