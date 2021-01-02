class CarrierStringIO < StringIO
  def original_filename
    "photo.jpeg"
  end

  def content_type
    "image/jpeg"
  end
end

class Profile < ApplicationRecord
  validates :user_id, presence: true, uniqueness: true
  validates :major_category, numericality: { only_integer: true, greater_than_or_equal_to: 0, less_than_or_equal_to: 13, message: "%{attribute}は0〜13の数字を入力してください。" }, allow_nil: true
  VALID_PHONE_REGEX = /\A\d{10}$|^\d{11}\z/
  validates :telephone, format: { with: VALID_PHONE_REGEX, message: "ハイフンなしの正しいフォーマットで入力してください。" }, allow_nil: true
  VALID_URL_REGEX = /\A#{URI::regexp(%w(http https))}\z/
  validates :company_site, format: { with: VALID_URL_REGEX, message: "正しいURLフォーマットを入力してください。" }, allow_nil: true

  belongs_to :user
  mount_uploader :thumbnail, ProfileThumbnailUploader

  # Will be called during standard assignment in controller
  def image_file=(uri_str)
    image_data = split_base64(uri_str.to_s)
    image_data_string = image_data[:data]
    io = CarrierStringIO.new(Base64.decode64(image_data_string))
    self.thumbnail = io
  end
end
