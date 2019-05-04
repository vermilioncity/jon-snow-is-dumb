CarrierWave.configure do |config|
  config.fog_provider = 'fog/aws'
  config.fog_credentials = {
      provider:              'AWS',
      aws_access_key_id:     ENV['AWS_ACCESS_KEY'],
      aws_secret_access_key: ENV['AWS_SECRET_KEY'],
      region:                ENV['AWS_REGION'],
      host:                  ENV['DOMAIN_NAME'],
      endpoint:              'https://s3.example.com:8080',
      stub_responses:    Rails.env.test?
  }
  config.fog_directory  = ENV['S3_BUCKET']
  config.fog_public = true
  
end