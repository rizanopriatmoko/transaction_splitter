class AddConfirmationResponseToSingleDirectTransaction < ActiveRecord::Migration[6.0]
  def change
    add_column :single_direct_transactions, :confirmation_response, :text
  end
end
