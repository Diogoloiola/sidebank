module Transaction
  module Transfer
    module Create
      module Step
        class Persist < Micro::Case::Strict
          attributes :account_origin_id, :account_destiny_id, :value

          def call! # rubocop:disable Metrics/MethodLength
            transaction = Transaction::Record.new(
              account_origin_id:,
              account_destiny_id:,
              transaction_type: :transferencia,
              value:,
              hour: Time.zone.now.to_datetime
            )

            if transaction.save!
              Success result: { transaction: }
            else
              Failure :error, result: {
                errors: transaction.errors.full_messages.join(', ')
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
end
