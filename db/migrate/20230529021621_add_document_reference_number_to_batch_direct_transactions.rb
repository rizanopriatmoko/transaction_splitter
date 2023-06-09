class AddDocumentReferenceNumberToBatchDirectTransactions < ActiveRecord::Migration[6.0]
  def change
    add_column :batch_direct_transactions, :document_reference_number, :string
  end
end
