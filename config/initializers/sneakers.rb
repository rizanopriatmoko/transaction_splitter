require 'sneakers/metrics/logging_metrics'
require 'sneakers/handlers/maxretry'
Sneakers.configure(:connection => Bunny.new(
  host: ENV['MQ_HOST'],
  vhost: Rails.env.development? ? '/' : "#{Rails.env}",
  user: ENV['MQ_USER'],
  password: ENV['MQ_PASSWORD'],
  port: ENV['MQ_PORT'] || 5672,
  ssl: ENV['MQ_SSL'] == 'true'
), metrics: Sneakers::Metrics::LoggingMetrics.new, 
  handler: Sneakers::Handlers::Maxretry,
  :runner_config_file => nil,  # A configuration file (see below)
  :daemonize => true,          # Send to background
  # :start_worker_delay => 0.2,  # When workers do frenzy-die, randomize to avoid resource starvation
  :workers => 1,               # Number of per-cpu processes to run
  :log  => 'log/sneakers.log',     # Log file
  :pid_path => 'tmp/pids/sneakers.pid', # Pid file
  :timeout_job_after => 2.minutes,      # Maximal seconds to wait for job
  :prefetch => 1,              # Grab 10 jobs together. Better speed.
  :threads => 1,               # Threadpool size (good to match prefetch)
  :env => ENV['RACK_ENV'],      # Environment
  :durable => true,             # Is queue durable?
  # :ack => true,                 # Must we acknowledge?
  :heartbeat => 30,              # Keep a good connection with broker
  :exchange => 'sneakers',      # AMQP exchange
  :hooks => {},                  # before_fork/after_fork hooks
  :start_worker_delay => 10     # Delay between thread startup  
)
Sneakers.logger.level = Logger::INFO