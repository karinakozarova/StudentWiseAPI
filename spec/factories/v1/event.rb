FactoryBot.define do
  factory :event do
    association :creator, factory: :user
    event_type { :other }
    title { Faker::Lorem.sentence }
    description { Faker::Lorem.paragraph(sentence_count: 4) }
    starts_at { Faker::Time.between(from: DateTime.now, to: DateTime.now + 7) }
    finishes_at { Faker::Time.between(from: starts_at + 5.minutes, to: starts_at + 2.hours) }

    trait :duty do
      event_type { :duty }
    end

    trait :party do
      event_type { :party }
    end
  end
end
