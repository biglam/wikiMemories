 CarrierWave.configure do |config|

    # Use local storage if in development or test, AWS in production
    config.storage = Rails.env.production? ? :fog : :file

    # config/initializers/carrierwave.rb
    config.fog_credentials = {
      :provider  => 'AWS',  # required
      :aws_access_key_id  => ENV['AWS_ACCESS_KEY_ID'],  # required
      :aws_secret_access_key  => ENV['AWS_SECRET_ACCESS_KEY'],  # required
      :region => 'eu-west-1',  # optional, defaults to 'us-east-1'
    }
    config.fog_directory  = ENV['AWS_BUCKET_NAME']  # required
    config.fog_public  = true  # optional, defaults to true
  end