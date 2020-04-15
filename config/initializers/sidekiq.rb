# frozen_string_literal: true

redis = Rails.application.config.redis
config_hash = { host: redis.host, port: redis.port, password: redis.password }
Redis.current = Redis.new(config_hash)

Sidekiq.configure_server do |config|
  config.redis = config_hash
end

Sidekiq.configure_client do |config|
  config.redis = config_hash
end
