CarrierWave.configure do |config|
  config.fog_provider = 'fog/google',
  config.fog_credentials = {
    provider: 'Google',
    google_project: ENV['GOOGLE_PROJECT_ID'],
    google_application_default: true,
  }
  config.fog_directory = ENV['GOOGLE_CLOUD_BUCKET_NAME'] || ''

  case Rails.env
    when 'production', 'development'
      config.fog_directory = ENV['GOOGLE_CLOUD_BUCKET_NAME'] || ''
      # config.asset_host = ENV['S3_ASSET_HOST'] || ''

    when 'test'
      :file
  end
end
