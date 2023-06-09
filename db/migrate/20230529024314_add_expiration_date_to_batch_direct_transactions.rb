class AddExpirationDateToBatchDirectTransactions < ActiveRecord::Migration[6.0]
  def change
    add_column :batch_direct_transactions, :expiration_date, :datetime
  end
end
