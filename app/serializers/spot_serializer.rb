class SpotSerializer < ActiveModel::Serializer
  attributes :id

  has_one :profile, serializer: SpotProfileSerializer
  has_many :multi_profiles, serializer: SpotMultiProfileSerializer
end
