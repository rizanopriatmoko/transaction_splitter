class Rack::Attack

  Rack::Attack.cache.store = ActiveSupport::Cache::MemoryStore.new 

  throttle('api/v1/authenticate/ip', limit: 5, period: 1.minutes) do |req|
    if req.path == '/api/v1/authenticate' && req.post?
      req.ip
    end
  end

  self.throttled_response = lambda do |env|
    match_data = env['rack.attack.match_data']
    now = match_data[:epoch_time]

    headers = {
      'RateLimit-Limit' => match_data[:limit].to_s,
      'RateLimit-Remaining' => '0',
      'RateLimit-Reset' => (now + (match_data[:period] - now % match_data[:period])).to_s,
      "Content-Type" => "application/json"
    }

    message = 'You have exceeded the login attempts, please try again in 1 minute'


    [ 503,headers, [message]] # body
  end
end



