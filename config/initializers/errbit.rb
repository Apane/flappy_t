Airbrake.configure do |config|
  config.api_key = 'c1f5657e568fba70ef5ceb60fc1911e0'
  config.host    = 'errors.weavenow.us'
  config.port    = 80
  config.secure  = config.port == 443
end