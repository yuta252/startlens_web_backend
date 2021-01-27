class FavoriteSerializer < ActiveModel::Serializer
  attributes :id, :user_id, :tourist_id
end
