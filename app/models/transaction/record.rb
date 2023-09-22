module Transaction
  class Record < ApplicationRecord
    include Filterable

    self.table_name = 'transactions'

    belongs_to :origin, class_name: 'Account::Record', optional: false
    belongs_to :destiny, class_name: 'Account::Record', optional: true

    enum transaction_type: {
      deposito: 0,
      saque: 1,
      transferencia: 2
    }

    scope :filter_by_origin_id, ->(value) { where(origin_id: value) }
    scope :filter_by_transaction_type, ->(value) { where(transaction_type: value) }
  end
end
