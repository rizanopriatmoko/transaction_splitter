module Disbursements
    module Business
      module Partner1
        class Transaction
          include HTTParty
          include IntegrateCloudLogger
          require "uri"
          require "net/http"
  
  
          def self.create_quotation(payload)
                        # supposedly hit partner's end point
            return true
          end
  
          def self.create_payment(payload)
                        # supposedly hit partner's end point
            return true
          end

          def self.confirm_payment(payload)
                        # supposedly hit partner's end point
            return true
          end

        end
      end
    end
end