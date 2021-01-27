class ReviewSerializer < ActiveModel::Serializer
  attributes :id, :user_id, :tourist_id, :lang, :post_review, :rating, :created_at

  has_one :tourist, serializer: ReviewOwnerSerializer
end
