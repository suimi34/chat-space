CarrierWave.configure do |config|
  config.fog_credentials = {
    provider:               'AWS',
    aws_access_key_id:      'your_access_key_id',
    aws_secret_access_key:  'your_secret_access_key',
    region:                 'ap-northeast-1'
  }

  case Rails.env
    when 'production', 'development'
      config.fog_directory = 'tc-ex-chat-space-image'
      config.asset_host = 'https://s3-ap-northeast-1.amazonaws.com/dummy'

    when 'test'
      config.fog_directory = 'test.dummy'
  end
end
