class Favorite < ApplicationRecord

  validates :user_id, presence: true
  validates :tourist_id, presence: true, uniqueness: { scope: [:user_id], message: "既にお気に入り登録されています。"}

  belongs_to :tourist
  belongs_to :user
end
