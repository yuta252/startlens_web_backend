class ProfileSerializer < ActiveModel::Serializer
  attributes :id, :user_id, :major_category, :telephone, :company_site, :thumbnail
end
