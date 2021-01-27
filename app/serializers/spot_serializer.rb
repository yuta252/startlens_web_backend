class SpotSerializer < ActiveModel::Serializer
  attributes :id, :is_favorite

  has_one :profile, serializer: SpotProfileSerializer
  has_many :multi_profiles, serializer: SpotMultiProfileSerializer
  has_many :reviews, serializer: ReviewSerializer

  def is_favorite
    tourist_id = scope[:tourist_id]
    return false unless tourist_id
    Favorite.exists?(tourist_id: tourist_id, user_id: object.id)
  end
end
