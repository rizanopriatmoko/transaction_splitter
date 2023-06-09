class Publisher
  DEFAULT_OPTIONS = { durable: true, auto_delete: false }.freeze

  def self.publish(queue_name:"", payload:, exchange_name: 'sneakers', routing_key: nil )
    channel = ConnectionManager.instance.channel
    
    exc = channel.direct(exchange_name, durable: true)
    queue = channel.queue(queue_name, DEFAULT_OPTIONS.merge({:arguments => {"x-dead-letter-exchange" => "#{routing_key}-retry"}}) )
    routing_key = queue.name unless routing_key
    queue.bind(exc, routing_key: routing_key)
    exc.publish(payload, routing_key: routing_key, persistent: true)
  end
end