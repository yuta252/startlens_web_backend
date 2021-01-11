class SpotProfileSerializer < ActiveModel::Serializer
  attributes :id, :user_id, :major_category, :telephone, :company_site, :url, :rating

  def url
    object.thumbnail.url
  end

  def rating
    3.5
  end
end
