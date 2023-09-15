module Transaction
  class Record < ApplicationRecord
    self.table_name = 'transactions'

    belongs_to :origin, class_name: 'Account::Record', optional: false
    belongs_to :destiny, class_name: 'Account::Record', optional: false

    validates :transaction_type, :value, presence: true
    validates :value, comparison: { greater_than: 0 }
    # precisa validar se a transaction_type é diferente de 0, 1 ou 2?

    enum transaction_type: {
      deposito: 0,
      saque: 1,
      transferencia: 2
    }
  end
end
