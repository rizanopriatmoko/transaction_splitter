class BatchDirectTransaction < ApplicationRecord
    has_many :single_direct_transactions, class_name: "SingleDirectTransaction", foreign_key: "batch_id", dependent: :destroy
    serialize :recipient, Hash
    serialize :sender, Hash
    after_create :create_single_transaction

    state_machine :state, initial: :created do
        event :confirm do
            transition to: :confirmed, from: :created
        end
        event :submit do
            transition to: :submitted, from: :confirmed
        end
        after_transition to: :confirmed, do: :submit_single_transaction

        event :partial_submit do
            transition to: :partial_submitted, from: [:created, :confirmed]
        end
    end

    def create_quotation(payload, single_trx_amount, ref_id)
        quote = Disbursements::Business::Partner1::Transaction.create_quotation(payload.merge({
            "destination":{
                "amount": single_trx_amount,
                "currency": self.currency
            },
            "external_id": ref_id
        }))
        SingleDirectTransaction.create(
            'single_reference_id' => ref_id,
            'amount' => single_trx_amount,
            'batch_id'=> self.id,
            'quotation_response'=> quote
        )
        return quote
    end

    def generate_amount(amount, amount_limit)
        output = []
        remaining_amount = amount
        cycle = 0
        while remaining_amount > 0
            # single amount subtractor
            cycle+=1
            single_amount = amount_limit-cycle
            # conditional for last amount
            if remaining_amount < amount_limit
                # conditional for existing amount
                if output.include? remaining_amount 
                    single_amount = [(remaining_amount/2)+1, (remaining_amount/2)-1]
                else 
                    single_amount = remaining_amount
                end
                # conditional for minimum amount
                if remaining_amount < 50 
                    single_amount = remaining_amount + 50
                    new_amount = output.last-50
                    output.pop 
                    output << new_amount
                end
            end
            # byebug
            output << single_amount 
            single_amount.class != Array ? remaining_amount -= single_amount : remaining_amount = 0
        end
        return output.flatten
    end
    
    def create_single_transaction
        payload = {
            "payer_id": self.bank_id,
            "mode": "DESTINATION_AMOUNT",
            "transaction_type": self.transaction_type,
            "source": {
              "currency": "IDR",
              "country_iso_code": "IDN"
            }
          }
        amounts = self.generate_amount(self.amount, self.amount_limit_per_trx)
        self.update(single_transaction_length: amounts.length)
        amounts.each_with_index{|amount, i| self.create_quotation(payload, amount, "#{self.reference_id}-#{i}")}
        self.update(expiration_date: self.created_at + 12.hours)
    end

    def submit_single_transaction 
        self.single_direct_transactions.each{|trx| trx.confirm! unless trx.confirmed?}
    end

    def bene_name 
        self.transaction_type ==  "B2B" ? self.recipient['registered_name'] : "#{self.recipient['firstname']} #{self.recipient['lastname']}"
    end

    def sender_name
        self.sender['registered_name']
    end

    def merger
        if self.transaction_type == "B2B"
            {
                "receiving_business": self.recipient,
                "sending_business": self.sender.merge(country_iso_code: "IDN")
            }
        elsif self.transaction_type == "B2C"
            {
                "beneficiary": self.recipient,
                'sending_business': self.sender.merge(country_iso_code: "IDN")
            }
        end
    end
end
