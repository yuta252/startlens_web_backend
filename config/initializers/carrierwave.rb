require 'carrierwave/storage/abstract'
require 'carrierwave/storage/file'
require 'carrierwave/storage/fog'

if Rails.env.production?
  CarrierWave.configure do |config|
    config.storage = :fog
    config.fog_provider = 'fog/aws'
    config.fog_directory = 'startlens-media-storage'
    config.asset_host = 'https://s3-ap-northeast-1.amazonaws.com/startlens-media-storage'

    config.fog_credentials = {
      provider: 'AWS',
      aws_access_key_id: ENV['AWS_ACCESS_KEY_ID'],
      aws_secret_access_key: ENV['AWS_SECRET_ACCESS_KEY'],
      region: ENV['AWS_DEFAULT_REGION']
    }

    # save cache in S3
    config.cache_storage = :fog
  end
else
  CarrierWave.configure do |config|
    config.asset_host = 'http://0.0.0.0:80'
  end
end