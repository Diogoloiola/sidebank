class DeviseTokenAuthCreateCustomers < ActiveRecord::Migration[7.0]
  def change # rubocop:disable Metrics/MethodLength, Metrics/AbcSize
    create_table(:customer_customers) do |t|
      ## Required
      t.string :provider, null: false, default: 'email'
      t.string :uid, null: false, default: ''

      ## Database authenticatable
      t.string :encrypted_password, null: false, default: ''

      ## Recoverable
      t.string   :reset_password_token
      t.datetime :reset_password_sent_at
      t.boolean  :allow_password_change, default: false

      ## Rememberable
      t.datetime :remember_created_at

      ## Confirmable
      t.string   :confirmation_token
      t.datetime :confirmed_at
      t.datetime :confirmation_sent_at
      t.string   :unconfirmed_email # Only if using reconfirmable

      ## User Info
      t.string :name
      t.string :email
      t.string :cpf
      t.string :cellphone
      t.date :birthdate
      t.boolean :active, default: false

      ## Tokens
      t.json :tokens

      t.timestamps
    end

    add_index :customer_customers, :email, unique: true
    add_index :customer_customers, %i[uid provider], unique: true
    add_index :customer_customers, :reset_password_token, unique: true
    add_index :customer_customers, :confirmation_token,   unique: true
    # add_index :customers, :unlock_token,         unique: true
  end
end
