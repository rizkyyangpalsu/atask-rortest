class CreateWallets < ActiveRecord::Migration[7.2]
  def change
    create_table :wallets do |t|
      t.decimal :balance, precision: 15, scale: 2, default: 0
      t.references :entity, polymorphic: true, null: false

      t.timestamps
    end
  end
end
