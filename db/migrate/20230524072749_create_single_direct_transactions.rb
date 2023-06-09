class CreateSingleDirectTransactions < ActiveRecord::Migration[6.0]
  def change
    create_table :single_direct_transactions do |t|
      t.string :single_reference_id
      t.float :amount
      t.integer :batch_id

      t.timestamps
    end
  end
end
