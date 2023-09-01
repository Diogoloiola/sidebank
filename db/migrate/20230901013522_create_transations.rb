class CreateTransations < ActiveRecord::Migration[7.0]
  def change
    create_table :transations, id: :uuid do |t|
      t.integer :transaction_type
      t.decimal :value
      t.date :date_transaction
      t.references :customer_customer, null: false, foreign_key: true, type: :uuid
      t.references :customer_customer, null: false, foreign_key: true, type: :uuid
      t.text :description

      t.timestamps
    end
  end
end
