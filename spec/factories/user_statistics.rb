FactoryBot.define do
  factory :user_statistic do
    association :user
    association :tourist

    trait :today do
      created_at { Date.current.in_time_zone }
    end

    trait :yesterday do
      created_at { 1.day.ago }
    end

    trait :tomorrow do
      created_at { 1.day.from_now }
    end
  end
end
