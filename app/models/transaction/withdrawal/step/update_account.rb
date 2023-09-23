module Transaction
  module Withdrawal
    module Step
      class UpdateAccount < Micro::Case::Strict
        attributes :transaction

        def call! # rubocop:disable Metrics/MethodLength
          account = transaction.account_origin
          if account.update(balance: account.balance - transaction.value)
            Success result: { transaction: }
          else
            Failure :error, result: {
              errors: account.errors.full_messages.join(', ')
            }
          end
        rescue StandardError => e
          Failure :error, result: {
            errors: e.message
          }
        end
      end
    end
  end
end
