module Customer
  module Create
    class RegisterCustomer < Micro::Case
      attributes :name, :email, :cpf, :birthdate, :cellphone

      def call! # rubocop:disable Metrics/AbcSize, Metrics/MethodLength
        errors = validate_params!

        if errors.present?

          return Failure :invalid_attributes, result: {
            errors: OpenStruct.new(full_messages: errors)
          }
        end

        customer = Customer::Record.new(
          name:,
          email:,
          cpf:,
          birthdate:,
          cellphone:,
          skip_password_validation: true
        )

        if customer.save!
          CustomerMailer.with(customer:).welcome_email.deliver_now
          Success result: { customer: }
        else
          Failure :invalid_attributes, result: {
            errors: OpenStruct.new(full_messages: customer.erros.messages)
          }
        end
      end

      private

      def validate_params!
        errors = []

        errors << { attribute: 'name', message: 'O nome não pode ser vazio' } if name.blank?
        errors << { attribute: 'cellphone', message: 'O celular não pode ser vazio' } if cellphone.blank?
        errors << { attribute: 'birthdate', message: 'A data deve está presente' } if birthdate.blank?
        errors << { attribute: 'email', message: 'Email é inválido' } unless email.match?(URI::MailTo::EMAIL_REGEXP)
        errors << { attribute: 'cpf', message: 'CPF não é válido' } unless CPF.valid?(cpf)

        errors
      end
    end
  end
end
