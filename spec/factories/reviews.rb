FactoryBot.define do
  factory :review do
    association :user
    association :tourist
    lang { "ja" }
    post_review { "ここは最高によかった" }
    rating { 3 }
  end

  factory :review2, class: Review do
    association :user
    association :tourist
    lang { "en" }
    post_review { "Thats awesome" }
    rating { 5 }
  end

  factory :review3, class: Review do
    association :user
    association :tourist
    lang { "en" }
    post_review { "Not bad" }
    rating { 1 }
  end
end
