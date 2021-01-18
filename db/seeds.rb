############
# 開発環境用 #
############

lang_category = ["ja", "en", "zh-CN", "zh-TW", "ko"]
sex_category = [1, 2, 3]
birth_category = [
  1940, 1941, 1942, 1943, 1944,
  1945, 1946, 1947, 1948, 1949,
  1950, 1951, 1952, 1953, 1954,
  1955, 1956, 1957, 1958, 1959,
  1960, 1961, 1962, 1963, 1964,
  1965, 1966, 1967, 1968, 1969,
  1970, 1971, 1972, 1973, 1974,
  1975, 1976, 1977, 1978, 1979,
  1980, 1981, 1982, 1983, 1984,
  1985, 1986, 1987, 1988, 1989,
  1990, 1991, 1992, 1993, 1994,
  1995, 1996, 1997, 1998, 1999,
  2000, 2001, 2002, 2003, 2004,
  2005, 2006, 2007, 2008, 2009,
  2010, 2011, 2012, 2013, 2014,
  2015
]

country_category = ["JP", "KR", "TW", "CN", "US", "GB"]

def rand_time(from, to=Time.now)
  Time.at(rand_in_range(from.to_f, to.to_f))
end

def rand_in_range(from, to)
  rand * (to - from) + from
end


User.create!(email: "info@startlens.com", password: "startlens")

Profile.create!(
  user_id: 1,
  thumbnail: File.open('./app/assets/images/thumbnail.png', ?r),
  major_category: 22,
  latitude: 35.6763976,
  longitude: 139.6971372,
  telephone: "0333795511",
  company_site: "https://www.meijijingu.or.jp/",
)

MultiProfile.create!(
  user_id: 1,
  lang: "ja",
  username: "明治神宮",
  self_intro: "明治天皇と昭憲皇太后を祭神とする。境内はそのほとんどが全国青年団の勤労奉仕により造苑整備されたもので、現在の深い杜の木々は全国からの献木が植樹された。また、本殿を中心に厄除・七五三などの祈願を行う神楽殿、「明治時代の宮廷文化を偲ぶ御祭神ゆかりの御物を陳列する」宝物殿、「御祭神の大御心を通じて健全なる日本精神を育成する」武道場至誠館などがある。新年には毎年のように国内外から観光客が集まり、初詣では例年の参拝者数が1位となっている",
  address_prefecture: "東京都",
  address_city: "渋谷区代々木神園町",
  address_street: "1-1",
  entrance_fee: "参拝料無料",
  business_hours: "6:40~16:20(日の出、日の入りにあわせて毎月変更)",
  holiday: "年中無休",
  translated: 1,
)


Tourist.create!(
  email: "test@startlens.com",
  password: "startlens",
  username: "イカの妖精",
  thumbnail: File.open('./app/assets/images/user_thumbnail.jpg', ?r),
  sex: 1,
  birth: 1992,
  country: "JP",
  lang: "ja",
  is_active: true
)


100.times do |n|
  Tourist.create!(
    email: "#{n}" + Faker::Internet.unique.email,
    password: "startlens",
    username: Faker::Name.unique.name,
    thumbnail: "",
    sex: rand(1..3),
    birth: birth_category[rand(75)],
    lang: lang_category[rand(4)],
    country: country_category[rand(5)],
    is_active: true
  )
end

2000.times do |n|
  p "#{n} is created"
  user = UserStatistic.new(
    user_id: 1,
    tourist_id: (((n * rand(1..100)) % 100).to_i + 1),
    created_at: rand_time(1.years.ago)
  )
  user.save(validate: false)
end