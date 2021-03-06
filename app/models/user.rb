class User < ApplicationRecord
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-]+(\.[a-z\d\-]+)*\.[a-z]+\z/i
  # TODO: 国際化ドメイン対応
  validates :email, presence: { message: "%{attribute}を入力してください。" },
            length: { maximum: 255, message: "%{attribute}は255文字以下で入力してください。" },
            format: { with: VALID_EMAIL_REGEX, message: "正しいフォーマットを入力してください。" },
            uniqueness: { message: "この%{attribute}はすでに登録されています。" }

  has_secure_password
  validates :password, presence: { message: "パスワードを入力してください" },
            length: { minimum: 6, message: "%{attribute}は6文字以上で入力してください。" },
            allow_nil: true

  has_one :profile, dependent: :destroy
  has_many :multi_profiles, dependent: :destroy
  has_many :exhibits, dependent: :destroy
  has_many :reviews, dependent: :destroy
  has_many :favorites, dependent: :destroy
  has_many :user_statistics

  scope :with_profile, -> { joins(:profile) }
  scope :with_multi_profile, -> { joins(:multi_profiles) }
  scope :with_favorite, -> { joins(:favorites) }
  scope :extract_by_count, lambda { |keyword|
    order(created_at: :desc).limit(keyword)
  }
  scope :filter_by_category, lambda { |keyword|
    where('major_category LIKE ?', "#{keyword}")
  }
  scope :filter_by_username, lambda { |keyword|
    where('LOWER(username) LIKE ?', "%#{keyword}%")
  }
  scope :filter_by_prefecture, lambda { |keyword|
    where('LOWER(address_prefecture) LIKE ?', "#{keyword}%").select(:id).distinct
  }
  scope :filter_by_tourist, lambda { |keyword|
    where('tourist_id = ?', keyword)
  }

  def self.search(params={})
    spots = User.all
    spots = spots.extract_by_count(params[:items].to_i) if params[:items]
    spots = spots.with_profile.filter_by_category(params[:category]) if params[:category]
    spots = spots.with_multi_profile.filter_by_username(params[:query]) if params[:query]
    spots = spots.with_multi_profile.filter_by_prefecture(params[:prefecture]) if params[:prefecture]
    spots
  end

  def self.get_favorite(tourist_id)
    spots = User.with_favorite.filter_by_tourist(tourist_id)
    spots
  end
end
