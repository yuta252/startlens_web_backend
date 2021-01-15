class Tourist < ApplicationRecord
  require './app/utils/carrier_string'
  include CarrierwaveBase64Uploader

  attr_accessor :image_file

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
  validates :username, presence: { message: "%{attribute}を入力してください。" }

  has_many :reviews, dependent: :destroy
  has_many :favorites, dependent: :destroy
  has_many :exhibit_favorites, dependent: :destroy

  mount_uploader :thumbnail, TouristThumbnailUploader

  # Will be called during standard assignment in controller
  def image_file=(uri_str)
    image_data = split_base64(uri_str.to_s)
    image_data_string = image_data[:data]
    content_type = image_data[:type]
    extention = image_data[:extension]
    io = CarrierStringIO.new(Base64.decode64(image_data_string))
    self.thumbnail = io
  end
end
