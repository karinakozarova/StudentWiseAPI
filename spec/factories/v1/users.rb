FactoryBot.define do
  factory :user do
    association :group
    email { Faker::Internet.email }
    first_name { Faker::Name.first_name }
    last_name { Faker::Name.last_name }
    admin { false }
    password { Faker::Internet.password }

    trait(:admin) { admin { true } }
  end
end
