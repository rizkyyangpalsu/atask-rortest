class CreateTeams < ActiveRecord::Migration[7.2]
  def change
    create_table :teams do |t|
      t.string :name
      t.string :username, null: false
      t.string :password_digest, null: false

      t.timestamps
    end

    add_index :teams, :username, unique: true
  end
end
