class TouristSerializer < ActiveModel::Serializer
  attributes :id, :email, :username, :sex, :birth, :country, :lang
end
