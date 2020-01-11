FactoryBot.define do
  factory :event_vote do
    association :event
    association :voter, factory: :user
    finished { Faker::Boolean.boolean }

    trait(:finished) { finished { true } }
    trait(:unfinished) { finished { false } }
  end
end
