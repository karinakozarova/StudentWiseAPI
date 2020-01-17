FactoryBot.define do
  factory :expense do
    association :creator, factory: :user
    association :group
    name { Faker::Lorem.sentence(word_count: 2) }
    notes { Faker::Lorem.sentence }
    price { Faker::Number.decimal(l_digits: 2) }
    quantity { Faker::Number.between(from: 1, to: 10) }
    archived { Faker::Boolean.boolean }

    trait(:archived) { archived { true } }
    trait(:unarchived) { archived { false } }
  end
end
