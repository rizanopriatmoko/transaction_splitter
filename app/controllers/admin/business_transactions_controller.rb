class Admin::BusinessTransactionsController < AdminController

    def new
      
    end
    
    def quote
      @partner = params['business_transaction']['partner']
      if @partner == 'Partner3'
        @quotation = Disbursements::Business::Partner3::Transaction.create_quotation(params['business_transaction']['quotation'])
      else
        @quotation = Disbursements::Business::Partner2::Transaction.create_quotation(params['business_transaction']['quotation'])
      end    
    end
    
    def payment
      if JSON.parse(params['business_transaction']['payment']).keys.include? 'originSender'
        @payment = Disbursements::Business::Partner3::Transaction.create_payment(params['business_transaction']['payment'])
      else
        @payment = Disbursements::Business::Partner2::Transaction.create_payment(params['business_transaction']['payment'])
      end
    end
end
  