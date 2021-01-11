FactoryBot.define do
  factory :profile do
    association :user
    major_category { 11 }
    telephone { "09055556666" }
    company_site { "http://google.com" }
  end

  factory :profile2, class: Profile do
    association :user
    major_category { 21 }
    telephone { "09055556666" }
    company_site { "http://google.com" }
  end

  factory :profile3, class: Profile do
    association :user
    major_category { 27 }
    telephone { "09055556666" }
    company_site { "http://google.com" }
  end
end
