class CreateTransactions < ActiveRecord::Migration[7.0]
  def change
    create_table :transactions, id: :uuid do |t|
      t.integer :transaction_type
      t.decimal :value
      t.datetime :date_transaction
      t.references :origin_id, null: false, foreign_key: { to_table: :account_accounts }, type: :uuid
      t.references :destiny_id, null: false, foreign_key: { to_table: :account_accounts }, type: :uuid
      t.text :description

      t.timestamps
    end
  end
end
