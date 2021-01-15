class ReviewSerializer < ActiveModel::Serializer
  attributes :id, :user_id, :tourist_id, :lang, :post_review, :rating, :created_at
end
