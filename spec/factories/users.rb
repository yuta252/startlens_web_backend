FactoryBot.define do
  factory :user do
    sequence(:email) { |n| "sample#{n}@gmail.com" }
    password { "sampletest" }
  end
end
