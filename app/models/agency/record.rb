module Agency
  class Record < ApplicationRecord
    self.table_name = 'agencie_agencies'

    validates :name, :code, presence: true
    validates :code, uniqueness: true

    has_many :accounts, class_name: 'Acccount::Record', foreign_key: :account_id
  end
end
