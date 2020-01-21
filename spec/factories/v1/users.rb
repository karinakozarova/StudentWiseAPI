FactoryBot.define do
  factory :user do
    association :group
    email { Faker::Internet.email }
    first_name { Faker::Name.first_name }
    last_name { Faker::Name.last_name }
    admin { false }
    two_fa_enabled { false }
    password { Faker::Internet.password }

    trait(:admin) { admin { true } }
    trait(:two_fa) do
      two_fa_enabled { true }
      two_fa_secret { generate_two_fa_secret }
      two_fa_challenge { generate_two_fa_challenge }
    end
  end
end
