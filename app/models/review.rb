class Review < ApplicationRecord

  validates :user_id, presence: true
  validates :tourist_id, presence: true
  validates :lang, presence: true
  validates :post_review, presence: { message: "%{attribute}を入力してください。" }
  validates :rating, presence: { message: "%{attribute}を入力してください。" }

  belongs_to :tourist
end
