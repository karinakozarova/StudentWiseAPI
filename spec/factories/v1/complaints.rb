FactoryBot.define do
  factory :complaint do
    association :creator, factory: :user
    status { :sent }
    title { Faker::Lorem.sentence }
    description { Faker::Lorem.paragraph(sentence_count: 4) }
  end
end
