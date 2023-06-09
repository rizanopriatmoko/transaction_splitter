class AddPurposeOfRemittanceToBatchDirectTransactions < ActiveRecord::Migration[6.0]
  def change
    add_column :batch_direct_transactions, :purpose_of_remittance, :string
  end
end
