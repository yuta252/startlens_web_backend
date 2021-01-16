class SpotProfileSerializer < ActiveModel::Serializer
  attributes :id, :user_id, :major_category, :telephone, :company_site, :url, :rating, :rating_count, :latitude, :longitude

  attr_accessor :static

  def url
    object.thumbnail.url
  end

  def rating
    self.static = Review.review_static(object.user_id)
    self.static[:average]
  end

  def rating_count
    self.static[:count]
  end
end
