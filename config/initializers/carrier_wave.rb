
CarrierWave.configure do |config|

  if Rails.env.staging? || Rails.env.production?

    config.storage = :fog

    config.fog_credentials = {
      provider: 'AWS',
      aws_access_key_id: Figaro.env.aws_access_key_id,
      aws_secret_access_key: Figaro.env.aws_secret_access_key
    }

    config.fog_directory = Figaro.env.s3_bucket_name
  else

    config.storage = :file
    config.enable_processing = Rails.env.development?
  end
end
