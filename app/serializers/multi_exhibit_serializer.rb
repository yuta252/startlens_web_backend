class MultiExhibitSerializer < ActiveModel::Serializer
  attributes :id, :exhibit_id, :lang, :name, :description
end
