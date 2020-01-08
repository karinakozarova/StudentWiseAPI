FactoryBot.define do
  factory :event_participant do
    association :event
    association :participant, factory: :user
  end
end
