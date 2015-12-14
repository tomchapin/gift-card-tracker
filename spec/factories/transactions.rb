FactoryGirl.define do
  factory :transaction do
    gift_card nil
    amount { Faker::Number.between(0, 100000) }
  end

end
