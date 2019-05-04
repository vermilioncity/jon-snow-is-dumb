CarrierWave.configure do |config|
  if Rails.env.staging? || Rails.env.production?
    config.fog_provider = 'fog/aws'
    config.fog_credentials = {
        provider:              'AWS',
        aws_access_key_id:     ENV['AWS_ACCESS_KEY'],
        aws_secret_access_key: ENV['AWS_SECRET_KEY'],
        region:                ENV['AWS_REGION'],
        stub_responses:    Rails.env.test?
    }
    config.fog_directory  = ENV['S3_BUCKET']
    config.fog_public = true
    config.storage = :fog
  else
    config.storage = :file
    config.enable_processing = Rails.env.development?
  end

end