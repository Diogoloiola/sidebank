module Customer
  module Create
    class Persist < Micro::Case::Strict
      attributes :name, :email, :cpf, :birthdate, :cellphone

      def call! # rubocop:disable Metrics/MethodLength
        customer = Customer::Record.new(
          name:,
          email:,
          cpf: CPF.new(cpf).formatted,
          birthdate:,
          cellphone:,
          skip_password_validation: true
        )

        if customer.save!
          Success result: { customer: }
        else
          Failure :error, result: {
            errors: customer.errors.messages
          }
        end
      rescue StandardError => e
        Failure :error, result: {
          errors: [e.message]
        }
      end
    end
  end
end
