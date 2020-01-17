FactoryBot.define do
  factory :group do
    name { Faker::Lorem.sentence }
    description { Faker::Lorem.paragraph(sentence_count: 4) }
    rules { Faker::Lorem.paragraph(sentence_count: 4) }
  end
end
