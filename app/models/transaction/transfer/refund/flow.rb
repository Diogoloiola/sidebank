module Transaction
  module Transfer
    module Refund
      class Flow < Micro::Case::Strict
        attributes :transaction_id

        def call! # rubocop:disable Metrics/MethodLength, Metrics/AbcSize
          transaction = Transaction::Record.find(transaction_id)

          errors = validate_transaction(transaction)

          return Failure(:invalid_attributes, result: { errors: }) if errors.any?

          account_origin = transaction.origin
          account_destiny = transaction.destiny

          account_origin.update(balance: account_origin.balance + transaction.value)
          account_destiny.update(balance: account_destiny.balance - transaction.value)

          transaction.update(reverted: true)

          Success result: { transaction: }
        rescue StandardError => e
          Failure :error, result: {
            errors: e.message
          }
        end

        private

        def validate_transaction(transaction)
          errors = []

          errors << 'Essa transferência já foi revertida!!' if transaction.reverted?

          errors
        end
      end
    end
  end
end
