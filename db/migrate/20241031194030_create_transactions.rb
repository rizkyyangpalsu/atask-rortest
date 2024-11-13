class CreateTransactions < ActiveRecord::Migration[7.2]
  def change
    create_table :transactions do |t|
      t.decimal :amount, precision: 15, scale: 2, null: false
      t.string :type, null: false
      t.integer :source_wallet_id, index: true
      t.integer :target_wallet_id, index: true

      t.timestamps
    end
  end
end
