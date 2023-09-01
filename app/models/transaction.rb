module Transaction
  class Record < ApplicationRecord
    self.table_name = 'transaction_transactions'

    belongs_to :origin_id, class_name: 'Customer::Record', optional: false
    belongs_to :destiny_id, class_name: 'Customer::Record', optional: false

    enum transaction_type: {
      deposito: 0,
      saque: 1,
      transferencia: 2
    }
  end
end
