Sentry.init do |config|
  config.dsn = 'https://b53aa90e1d0e4822b86c991dd5bc3a95@o862143.ingest.sentry.io/6088677'
  config.breadcrumbs_logger = [:active_support_logger, :http_logger, :sentry_logger]
  config.environment = Rails.env
  config.traces_sample_rate = Rails.env.production? ? 0.25 : 1
end