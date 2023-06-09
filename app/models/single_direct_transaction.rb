class SingleDirectTransaction < ApplicationRecord
    belongs_to :batch, class_name: "BatchDirectTransaction", foreign_key: "batch_id"
    
    state_machine :state, initial: :created do
        event :confirm do
            transition to: :confirmed, from: [:created, :rejected]
        end
        event :submit do
            transition to: :submitted, from: :confirmed
        end
        after_transition to: :confirmed, do: :submit_trx
        
        event :reject do
            transition to: :rejected, from: :confirmed
        end

        event :complete do
            transition to: :completed, from: :submitted
        end
    end

    def submit_trx
        payload = {
            "credit_party_identifier": {
                "bank_account_number": self.batch.bank_account_number
            },
            "external_id": self.single_reference_id,
            "document_reference_number": self.batch.document_reference_number,
            'purpose_of_remittance': self.batch.purpose_of_remittance
        }.merge(self.batch.merger)
        transaction = Disbursements::Business::Partner1::Transaction.create_payment(payload)
        if transaction
            Disbursements::Business::Partner1::Transaction.confirm_payment(payload)
            self.update(confirmation_response: transaction)
        else
            self.reject! unless self.rejected?
            self.batch.partial_submit! unless self.batch.partial_submitted?
            self.update(confirmation_response: transaction)
        end
    end
end
