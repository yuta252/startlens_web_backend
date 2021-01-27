class Review < ApplicationRecord

  validates :user_id, presence: true
  validates :tourist_id, presence: true, uniqueness: { scope: [:user_id], message: "既にレビューが投稿されています。" }
  validates :lang, presence: { message: "%{attribute}を入力してください。" }
  validates :post_review, presence: { message: "%{attribute}を入力してください。" }
  validates :rating, presence: { message: "%{attribute}を入力してください。" },
            numericality: { greater_than_or_equal_to: 0, less_than_or_equal_to: 5, message: "%{attribute}は0以上5以下の数字を入力してください。"}

  belongs_to :tourist
  belongs_to :user

  def self.review_static(user_id)
    reviews = self.where(user_id: user_id)
    count = reviews.count

    if reviews.exists?
      { average: BigDecimal(reviews.sum(:rating) / count).ceil(1).to_f, count: count }
    else
      { average: 0.0, count: 0 }
    end
  end
end
