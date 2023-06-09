class CreateBatchDirectTransactions < ActiveRecord::Migration[6.0]
  def change
    create_table :batch_direct_transactions do |t|
      t.string :reference_id
      t.string :transaction_type
      t.string :currency
      t.float :amount
      t.float :amount_limit_per_trx
      t.string :bank_account_number
      t.integer :bank_id
      t.text :sender
      t.text :recipient

      t.timestamps
    end
  end
end
