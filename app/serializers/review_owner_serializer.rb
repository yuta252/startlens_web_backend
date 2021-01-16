class ReviewOwnerSerializer < ActiveModel::Serializer
  attributes :id, :username, :thumbnail_url

  def thumbnail_url
    object.thumbnail.url
  end
end
