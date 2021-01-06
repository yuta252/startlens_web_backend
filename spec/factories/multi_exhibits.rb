FactoryBot.define do
  factory :multi_exhibit do
    association :exhibit
    lang { "ja" }
    name { "明治神宮" }
    description { "明治神宮は大正3年に" }
  end

  factory :multi_exhibit2, class: MultiExhibit do
    association :exhibit
    lang { "en" }
    name { "Meijijingu" }
    description { "Meiji Jingu is..." }
  end
end
