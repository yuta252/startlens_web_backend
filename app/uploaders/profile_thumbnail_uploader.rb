class ProfileThumbnailUploader < CarrierWave::Uploader::Base
  # Include RMagick or MiniMagick support:
  # include CarrierWave::RMagick
  include CarrierWave::MiniMagick

  # Choose what kind of storage to use for this uploader:
  if Rails.env.development?
    storage :file
  elsif Rails.env.test?
    storage :file
  else
    storage :fog
  end

  # Convert jpg format and then save
  process convert: "jpg"

  # rotate appropreate direction by using Exif info and then remove Exif
  process :fix_exif_rotation_and_strip_exif

  # Override the directory where uploaded files will be stored.
  # This is a sensible default for uploaders that are meant to be mounted:
  def store_dir
    "uploads/#{model.class.to_s.underscore}/#{model.user.id}/#{model.id}"
  end

  # Provide a default URL as a default if there hasn't been a file uploaded:
  # def default_url(*args)
  #   # For Rails 3.1+ asset pipeline compatibility:
  #   # ActionController::Base.helpers.asset_path("fallback/" + [version_name, "default.png"].compact.join('_'))
  #
  #   "/images/fallback/" + [version_name, "default.png"].compact.join('_')
  # end

  # Process files as they are uploaded:
  process resize_to_fill: [500, 500, "Center"]

  # Create different versions of your uploaded files:
  # version :thumb do
  #   process resize_to_fit: [50, 50]
  # end

  # Add a white list of extensions which are allowed to be uploaded.
  def extension_whitelist
    %w(jpg jpeg png)
  end

  # Override the filename of the uploaded files:
  # https://github.com/carrierwaveuploader/carrierwave/wiki/How-to:-Create-random-and-unique-filenames-for-all-versioned-files#unique-filenames
  def filename
    "#{secure_token}.#{file.extension}" if original_filename.present?
  end

  def secure_token
    media_original_filenames_var = :"@#{mounted_as}_original_filenames"

    unless model.instance_variable_get(media_original_filenames_var)
      model.instance_variable_set(media_original_filenames_var, {})
    end

    unless model.instance_variable_get(media_original_filenames_var).map{|k,v| k }.include? original_filename.to_sym
      new_value = model.instance_variable_get(media_original_filenames_var).merge({"#{original_filename}": SecureRandom.uuid})
      model.instance_variable_set(media_original_filenames_var, new_value)
    end

    model.instance_variable_get(media_original_filenames_var)[original_filename.to_sym]
  end

  def fix_exif_rotation_and_strip_exif
    manipulate! do |img|
      img.auto_orient
      img.strip
      img = yield(img) if block_given?
      img
    end
  end
end
