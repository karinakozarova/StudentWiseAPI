FactoryBot.define do
  factory :expense do
    association :creator, factory: :user
    name { Faker::Lorem.sentence(word_count: 2) }
    notes { Faker::Lorem.sentence }
    price { Faker::Number.decimal(l_digits: 2) }
    amount { Faker::Number.between(from: 1, to: 10) }
  end
end
