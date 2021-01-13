class Favorite < ApplicationRecord

  validates :user_id, presence: true
  validates :tourist_id, presence: true, uniqueness: { scope: [:user_id]}

  belongs_to :tourist
  belongs_to :user
end
