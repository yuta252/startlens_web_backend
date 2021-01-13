FactoryBot.define do
  factory :tourist do
    sequence(:email) { |n| "sample#{n}@gmail.com" }
    password { "sampletest" }
    username { "テストユーザー" }
    sex { 1 }
    birth { 1987 }
    country { "US" }
    lang { "en" }
    is_active { true }
  end
end
