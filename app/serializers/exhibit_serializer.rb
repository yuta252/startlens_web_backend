class ExhibitSerializer < ActiveModel::Serializer
  attributes :id
  has_many :pictures, serializer: PictureSerializer
  has_many :multi_exhibits, serializer: MultiExhibitSerializer


  # レスポンス
  # {
  #   id: exhibit_id,
  #   pictures: [
  #     {
  #       id: picture_id,
  #       url: "picture_url"
  #     },
  #   ],
  #   multi_exhibits: [
  #     {
  #       id: multi_exhibit_id,
  #       exhibit_id: exhibit_id
  #       lang: "ja",
  #       name: "xxxx",
  #       description: "xxxx"
  #     }
  #   ]
  # }
end
