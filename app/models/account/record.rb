module Account
  class Record < ApplicationRecord
    self.table_name = 'account_accounts'

    belongs_to :agency, class_name: 'Agency::Record', optional: false
    belongs_to :customer, class_name: 'Customer::Record', optional: false

    validates :code, :account_type, :opening_date, presence: true
    validates :code, uniqueness: true

    enum account_type: {
      poupanca: 0,
      corrente: 1
    }
  end
end
