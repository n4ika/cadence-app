FactoryBot.define do
  factory :task do
    title { Faker::Lorem.sentence(word_count: 3) }
    description { Faker::Lorem.paragraph }
    due_date { 7.days.from_now }
    status { "pending" }
    association :project
  end
end