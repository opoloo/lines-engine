require 'carrierwave'
require 'carrierwave/orm/activerecord'

if Rails.env.test? or Rails.env.cucumber?
  CarrierWave.configure do |config|
    config.storage = :file #enable file storage
    config.enable_processing = false #diable processing
  end
end