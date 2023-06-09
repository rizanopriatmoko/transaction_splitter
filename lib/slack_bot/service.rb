module SlackBot
  class Service
    include HTTParty
    require "uri"
    require "net/http"

    base_uri Rails.application.secrets.slack_bot_url
    AUTH_TOKEN = Rails.application.secrets.slack_bot_token

    def self.send_notification(text, channel="slack-bot", category="Info", title="Notification")
      response = post('/', body: { "channel": channel, "category": category, "title": title, "text": text}, headers: {"authentication-token": AUTH_TOKEN})
      return response.parsed_response
    rescue => error
      # Ignore any errors when sending a push notification.
      Rails.logger.debug error
      return nil
    end

    def self.get_channels
      response = get('/channels', headers: {"authentication-token": AUTH_TOKEN, "Content-Type" => "application/json"})
      channel_list = JSON.parse(response.body).map{|x| x["name"]}
    rescue => error
      Rails.logger.debug error
      return nil
    end
  end
end