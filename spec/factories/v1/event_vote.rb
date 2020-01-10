FactoryBot.define do
  factory :event_vote do
    association :event
    association :voter, factory: :user
    finished { Faker::Boolean.boolean }

    trait :finished do
      finished { true }
    end

    trait :unfinished do
      finished { false }
    end
  end
end
