module Disbursements
    module Business
        module Partner1
            class Auth
  
            include HTTParty
            require "uri"
            require "net/http"
    
            base_uri Rails.application.config_for(:b2b_service)["partner_1_uri"]
            API_KEY= Rails.application.config_for(:b2b_service)["partner_1_api_key"]
            API_SECRET= Rails.application.config_for(:b2b_service)["partner_1_api_secret"]
            
            def self.run
                auth = {username: API_KEY, password: API_SECRET}
                return auth
            end
    
            def self.check_api
                response = get("/ping", basic_auth: self.run)
                return response
            end
    
            def self.balances
                response = get("/v2/money-transfer/balances", basic_auth: self.run)
                return response
            end
    
            def self.money_services
                response = get("/v2/money-transfer/services", basic_auth: self.run)
                return response
            end
    
            end
        end
    end
end