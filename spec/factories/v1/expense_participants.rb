FactoryBot.define do
  factory :expense_participant do
    association :expense
    association :participant, factory: :user
  end
end
