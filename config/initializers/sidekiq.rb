require 'sidekiq'

#$redis = Redis.new({:host=>'redis', :port=>6379})
redis_url = 'redis://redis:6379'
Sidekiq.configure_client do |config|
  config.redis = { url: redis_url }
end

Sidekiq.configure_server do |config|
  config.redis = { url: redis_url }
end