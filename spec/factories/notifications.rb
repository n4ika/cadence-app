FactoryBot.define do
  factory :notification do
    message { Faker::Lorem.sentence }
    association :user
    association :task
  end
end