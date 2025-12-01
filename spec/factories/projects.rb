FactoryBot.define do
  factory :project do
    title { Faker::Company.bs }
    association :user
  end
end
