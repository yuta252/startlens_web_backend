class CarrierStringIO < StringIO
  def original_filename
    "photo.jpg"
  end

  def content_type
    "image/jpg"
  end
end