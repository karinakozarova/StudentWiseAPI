FactoryBot.define do
  factory :agreement do
    association :creator, factory: :user
    title { Faker::Lorem.sentence }
    description { Faker::Lorem.paragraph(sentence_count: 4) }
  end
end
