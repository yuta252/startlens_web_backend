FactoryBot.define do
  factory :exhibit do
    association :user
  end

  factory :exhibit2, class: Exhibit do
    association :user
  end
end
