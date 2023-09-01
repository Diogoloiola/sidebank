class CreateTransations < ActiveRecord::Migration[7.0]
  def change
    create_table :transations, id: :uuid do |t|
      t.integer :transaction_type
      t.decimal :value
      t.date :date_transaction
      t.references :origin, null: false, foreign_key: { to_table: :account_accounts }, type: :uuid
      t.references :destiny, null: false, foreign_key: { to_table: :account_accounts }, type: :uuid
      t.text :description

      t.timestamps
    end
  end
end
