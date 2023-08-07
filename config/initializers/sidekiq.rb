require 'sidekiq-status'

Sidekiq.configure_server do |config|
  if Rails.env.production?
    config.redis = { url: ENV['REDIS_URL'] }
  else
    config.redis = { url: 'redis://localhost:6379/0' }
  end
  config.server_middleware do |chain|
    chain.add Sidekiq::Status::ServerMiddleware
  end
end

Sidekiq.configure_client do |config|
  if Rails.env.production?
    config.redis = { url: ENV['REDIS_URL'] }
  else
    config.redis = { url: 'redis://localhost:6379/0' }
  end
  config.client_middleware do |chain|
    chain.add Sidekiq::Status::ClientMiddleware
  end
end

