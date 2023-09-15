module Transation
  module Deposit
    module Step
      class Persit < Micro::Case::Strict
        attributes :origin_id, :value

        def call! # rubocop:disable Metrics/MethodLength
          transation = Transation::Record.new(
            origin_id:,
            transation_type: :deposito,
            value:,
            hour: Time.zone.now.to_datetime
          )

          if transation.save!
            Success result: { transation: }
          else
            Failure :error, result: {
              errors: transation.errors.full_messages.join(', ')
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
