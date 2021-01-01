class Profile < ApplicationRecord
  validates :user_id, presence: true, uniqueness: true
  validates :major_category, numericality: { only_integer: true, greater_than_or_equal_to: 0, less_than_or_equal_to: 13 }, allow_nil: true
  VALID_PHONE_REGEX = /\A\d{10}$|^\d{11}\z/
  validates :telephone, format: { with: VALID_PHONE_REGEX }, allow_nil: true
  VALID_URL_REGEX = /\A#{URI::regexp(%w(http https))}\z/
  validates :company_site, format: { with: VALID_URL_REGEX }, allow_nil: true

  belongs_to :user
end
