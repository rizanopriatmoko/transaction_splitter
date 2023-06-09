class AddStateToSingleDirectTransaction < ActiveRecord::Migration[6.0]
  def change
    add_column :single_direct_transactions, :state, :string
  end
end
