module Transaction
  class Record < ApplicationRecord
    self.table_name = 'transactions'

    belongs_to :origin, class_name: 'Account::Record', optional: false
    belongs_to :destiny, class_name: 'Account::Record', optional: true

    enum transaction_type: {
      deposito: 0,
      saque: 1,
      transferencia: 2
    }
  end
end
