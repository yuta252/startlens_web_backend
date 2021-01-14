class TouristSerializer < ActiveModel::Serializer
  attributes :id, :email, :username, :thumbnail_url, :sex, :birth, :country, :lang

  def thumbnail_url
    object.thumbnail.url
  end
end
