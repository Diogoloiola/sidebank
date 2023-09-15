module Account
  module Register
    module Step
      class Persist < Micro::Case::Strict
        attributes :customer_id, :agency_id, :account_type

        def call! # rubocop:disable Metrics/MethodLength
          code = generate_code

          account = Account::Record.new(
            customer_id:,
            agency_id:,
            account_type:,
            opening_date: Time.now,
            code:
          )

          if account.save!
            Success(result: { account: })
          else
            Failure(:errors, result: { errors: [account.errors.full_messages.join(', ')] })
          end
        rescue StandardError => e
          Failure(:errors, result: { errors: ["Ocorreu um erro: #{e.message}"] })
        end

        private

        def generate_code
          loop do
            code = rand(36**6).to_s(36).upcase
            return code unless Account::Record.exists?(code:)
          end
        end
      end
    end
  end
end
