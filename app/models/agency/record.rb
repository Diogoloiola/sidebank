module Agency
  class Record < ApplicationRecord
    self.table_name = 'agencie_agencies'

    validates :name, :code, presence: true
    validates :code, uniqueness: true
  end
end
