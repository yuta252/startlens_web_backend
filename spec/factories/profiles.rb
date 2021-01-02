FactoryBot.define do
  factory :profile do
    association :user
    thumbnail { File.open('./spec/assets/sample_test1.jpg, ?r') }
    major_category { 1 }
    telephone { "09055556666" }
    company_site { "http://google.com" }
  end
end
