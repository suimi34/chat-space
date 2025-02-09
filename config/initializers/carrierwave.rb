CarrierWave.configure do |config|
  config.storage                             = :gcloud
  config.gcloud_bucket                       = ENV['GOOGLE_CLOUD_BUCKET_NAME'] || 'chat-space'
  config.gcloud_bucket_is_public             = false
  config.gcloud_authenticated_url_expiration = 600

  config.gcloud_attributes = {
    expires: 600
  }

  config.gcloud_credentials = {
    gcloud_project: ENV['GOOGLE_PROJECT_ID'],
    google_application_default: Rails.env.production?,
    # gcloud_keyfile: ENV['GOOGLE_SERVICE_ACCOUNT_JSON']
  }
end
