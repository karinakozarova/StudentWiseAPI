FactoryBot.define do
  factory :event do
    association :creator, factory: :user
    event_type { :other }
    event_status { :pending }
    title { Faker::Lorem.sentence }
    description { Faker::Lorem.paragraph(sentence_count: 4) }
    starts_at { Faker::Time.between(from: DateTime.now, to: DateTime.now + 7) }
    finishes_at { Faker::Time.between(from: starts_at + 5.minutes, to: starts_at + 2.hours) }

    trait(:duty) { event_type { :duty } }
    trait(:party) { event_type { :party } }

    trait(:marked_as_finished) { event_status { :marked_as_finished } }

    trait(:with_participants) do
      after(:create) do |event|
        2.times do
          create(:event_participant, event_id: event.id)
        end
      end
    end
  end
end
