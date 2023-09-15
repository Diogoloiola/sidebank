module Transation
  module Transfer
    module Step
      class DepositDestiny < Micro::Case::Strict
        attributes :transation

        def call! # rubocop:disable Metrics/MethodLength
          account = transation.destiny
          if account.update(balance: account.balance + transation.value)
            Success result: { transation: }
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
