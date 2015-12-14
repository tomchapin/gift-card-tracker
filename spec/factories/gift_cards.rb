FactoryGirl.define do
  factory :gift_card do
    card_number { Faker::Business.credit_card_number }
    card_issuer nil
  end
end
