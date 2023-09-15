class CreateTransations < ActiveRecord::Migration[7.0]
  def change
    create_table :transations, id: :uuid do |t|
      t.integer :transation_type
      t.decimal :value
      t.datetime :hour
      t.references :origin, null: false, foreign_key: { to_table: :account_accounts }, type: :uuid
      t.references :destiny, null: true, foreign_key: { to_table: :account_accounts }, type: :uuid

      t.timestamps
    end
  end
end
