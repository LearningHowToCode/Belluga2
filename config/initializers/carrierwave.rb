CarrierWave.configure do |config|
  if Rails.env.production?
    config.fog_credentials = {
        provider: 'AWS',
        aws_access_key_id: ENV['AWS_ACCESS_KEY_D'],
        aws_secret_access_key: ENV['AWS_SECRET_ACCESS_KEY']
    }
    config.fog_directory  = 'avatars'
    config.storage = :fog
  else
    config.storage = :file
  end
end
