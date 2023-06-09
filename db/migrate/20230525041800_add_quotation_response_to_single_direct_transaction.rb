class AddQuotationResponseToSingleDirectTransaction < ActiveRecord::Migration[6.0]
  def change
    add_column :single_direct_transactions, :quotation_response, :text
  end
end
