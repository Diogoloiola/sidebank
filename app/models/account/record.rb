module Account
  class Record < ApplicationRecord
    self.table_name = 'account_accounts'

    belongs_to :agency, class_name: 'Agency::Record', optional: false
    belongs_to :customer, class_name: 'Customer::Record', optional: false

    has_many :deposits, lambda {
                          where(transaction_type: :deposito)
                        }, class_name: 'Transaction::Record', foreign_key: :account_origin_id
    has_many :withdrawals, lambda {
                             where(transaction_type: :saque)
                           }, class_name: 'Transaction::Record', foreign_key: :account_origin_id
    has_many :transfers, lambda {
                           where.not(transaction_type: %i[deposito saque])
                         }, class_name: 'Transaction::Record', foreign_key: :account_origin_id

    validates :code, :account_type, :opening_date, presence: true
    validates :code, uniqueness: true

    enum account_type: {
      poupanca: 0,
      corrente: 1
    }
  end
end
