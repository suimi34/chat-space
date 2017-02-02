CarrierWave.configure do |config|
  config.fog_credentials = {
    provider:               'AWS',
    aws_access_key_id:      ENV['S3_ACCESS_KEY_ID'],
    aws_secret_access_key:  ENV['S3_SECRET_ACCESS_KEY'],
    region:                 ENV['S3_AWS_REGION']
  }

  case Rails.env
    when 'production', 'development'
      config.fog_directory = ENV['S3_BUCKET_NAME']
      config.asset_host = ENV['S3_ASSET_HOST']

    when 'test'
      :file
  end
end
