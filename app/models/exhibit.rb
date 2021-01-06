class Exhibit < ApplicationRecord
  has_many :pictures, dependent: :destroy
  has_many :multi_exhibits, dependent: :destroy
  belongs_to :user

  validates :user_id, presence: true
end
