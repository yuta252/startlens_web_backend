class Picture < ApplicationRecord
  require './app/utils/carrier_string'
  include CarrierwaveBase64Uploader

  validates :exhibit_id, presence: true
  belongs_to :exhibit
  mount_uploader :image, ExhibitImageUploader

  def self.create_pictures(exhibit_id, picture_params)
    # this function will return "true" if all picuture are saved correctly
    return false if picture_params[:image_file].nil?

    # transaction process to register all pictures without error
    begin
      Picture.transaction do
        picture_params[:image_file].each do |picture|
          image_data = self.split_base64(picture.to_s)
          image_data_string = image_data[:data]
          logger.debug(image_data_string)
          io = CarrierStringIO.new(Base64.decode64(image_data_string))
          new_picture = Picture.new(exhibit_id: exhibit_id, image: io)
          logger.debug("before picture save")
          new_picture.save!
          logger.debug("success picture save")
        end
      end
    rescue => exception
      logger.debug("transaction failed: #{exception}")
      return false
    end
    true
  end
end
