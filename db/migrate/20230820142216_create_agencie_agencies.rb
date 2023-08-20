class CreateAgencieAgencies < ActiveRecord::Migration[7.0]
  def change
    create_table :agencie_agencies, id: :uuid do |t|
      t.string :name
      t.string :code

      t.timestamps
    end

    add_index :agencie_agencies, :code, unique: true
  end
end
