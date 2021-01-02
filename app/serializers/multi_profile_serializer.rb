class MultiProfileSerializer < ActiveModel::Serializer
  attributes :id, :user_id, :username, :self_intro, :address_prefecture, :address_city, :address_street, :entrance_fee, :business_hours, :holiday, :translated
end
