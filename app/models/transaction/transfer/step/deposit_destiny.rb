module Transaction
  module Transfer
    module Step
      class DepositDestiny < Micro::Case::Strict
        attributes :transaction

        def call! # rubocop:disable Metrics/MethodLength
          account = transaction.destiny
          if account.update(balance: account.balance + transaction.value)
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
