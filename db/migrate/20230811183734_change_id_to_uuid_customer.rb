class ChangeIdToUuidCustomer < ActiveRecord::Migration[7.0]
  def change
    add_column :customer_customers, :uuid, :uuid, default: 'uuid_generate_v4()', null: false

    change_table :customer_customers do |t|
      t.remove :id
      t.rename :uuid, :id
    end
    execute 'ALTER TABLE customer_customers ADD PRIMARY KEY (id);'
  end
end
