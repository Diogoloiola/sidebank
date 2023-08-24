class CreateAccountAccounts < ActiveRecord::Migration[7.0]
  def change # rubocop:disable Metrics/MethodLength
    create_table :account_accounts, id: :uuid do |t|
      t.string :code
      t.integer :account_type
      t.date :opening_date
      t.decimal :balance, default: 0
      t.boolean :active, default: true
      t.references :agency, null: false, foreign_key: { to_table: :agencie_agencies }, type: :uuid
      t.references :customer, null: false, foreign_key: { to_table: :customer_customers }, type: :uuid

      t.timestamps
    end

    add_index :account_accounts, :code, unique: true
  end
end
