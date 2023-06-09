class AddStateToBatchDirectTransaction < ActiveRecord::Migration[6.0]
  def change
    add_column :batch_direct_transactions, :state, :string
  end
end
