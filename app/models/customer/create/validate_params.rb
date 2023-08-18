module Customer
  module Create
    class ValidateParams < Micro::Case::Strict
      attributes :name, :email, :cpf, :birthdate, :cellphone

      def call!
        errors = fetch_erros

        return Success result: attributes if errors.empty?

        Failure :invalid_attributes, result: {
          errors: OpenStruct.new(full_messages: errors)
        }
      end

      def fetch_erros
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
