FactoryGirl.define do
  factory :card_issuer do
    name { Faker::Company.name }
  end
end
