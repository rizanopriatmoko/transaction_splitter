class AddSingleTransactionLengthToBatchDirectTransactions < ActiveRecord::Migration[6.0]
  def change
    add_column :batch_direct_transactions, :single_transaction_length, :integer
  end
end
