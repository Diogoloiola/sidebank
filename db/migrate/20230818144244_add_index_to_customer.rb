class AddIndexToCustomer < ActiveRecord::Migration[7.0]
  def change
    add_index :customer_customers, :cpf, unique: true
  end
end
