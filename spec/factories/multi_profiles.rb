FactoryBot.define do
  factory :multi_profile do
    association :user
    lang { "ja" }
    username { "明治神宮" }
    self_intro { "明治神宮は大正3年に" }
    address_prefecture { "東京都" }
    address_city { "渋谷区代々木神園町" }
    address_street { "1-1" }
    entrance_fee { "一般1800円" }
    business_hours { "月10:00 - 20:00" }
    holiday { "毎週火曜日" }
    translated { 0 }
  end

  factory :multi_profile2, class: MultiProfile do
    association :user
    lang { "en" }
    username { "MeijiJingu shrine" }
    self_intro { "MeijiJingu is " }
    address_prefecture { "Tokyo" }
    address_city { "Shibuya-ku,Yoyogi" }
    address_street { "1-1" }
    entrance_fee { "Adult 1800 yen" }
    business_hours { "Mon10:00 - 20:00" }
    holiday { "Every Tuesday" }
    translated { 0 }
  end
end
