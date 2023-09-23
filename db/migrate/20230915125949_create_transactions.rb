class CreateTransactions < ActiveRecord::Migration[7.0]
  def change
    create_table :transactions, id: :uuid do |t|
      t.integer :transaction_type
      t.decimal :value
      t.datetime :hour
      t.references :account_origin, null: false, foreign_key: { to_table: :account_accounts }, type: :uuid
      t.references :account_destiny, null: true, foreign_key: { to_table: :account_accounts }, type: :uuid

      t.timestamps
    end
  end
end
