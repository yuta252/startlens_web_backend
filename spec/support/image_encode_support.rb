require 'base64'

module ImageEncodeSupport
  def encode(file_name)
    image_file = File.read(Rails.root.join('spec', 'fixtures', file_name.to_s))
    # If apply Base64.encode method to the image_file, \n is added and failed to save image.
    base64_image = Base64.strict_encode64(image_file)
    "data:image/png;base64," + base64_image.to_s
  end
end

RSpec.configure do |config|
  config.include ImageEncodeSupport
end