class AddRevertedToTransaction < ActiveRecord::Migration[7.0]
  def change
    add_column :transactions, :reverted, :boolean, default: false
  end
end
