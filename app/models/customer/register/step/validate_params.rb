module Customer
  module Register
    module Step
      class ValidateParams < Micro::Case::Strict
        attributes :name, :email, :cpf, :birthdate, :cellphone

        ERROR_MESSAGES = {
          name: 'O nome não pode ser vazio',
          cellphone: 'O celular não pode ser vazio',
          birthdate: 'A data de nascimento deve estar presente e o usuário deve ter mais de 18 anos',
          email: 'Email é inválido',
          cpf: 'CPF não é válido'
        }.freeze

        def call!
          errors = fetch_errors

          return Success(result: attributes) if errors.empty?

          Failure(:invalid_attributes, result: { errors: })
        end

        private

        def fetch_errors
          errors = []

          attributes.each do |attribute, value|
            errors << error_message(attribute.to_sym) if value.blank? || !send("valid_#{attribute}?")
          end

          errors
        end

        def error_message(attribute)
          ERROR_MESSAGES[attribute]
        end

        def valid_email?
          email.match?(URI::MailTo::EMAIL_REGEXP)
        end

        def valid_cpf?
          CPF.valid?(cpf)
        end

        def valid_name?
          name.size >= 2
        end

        def valid_birthdate?
          ((Time.zone.now - birthdate.in_time_zone) / 1.year.seconds).floor >= 18
        end

        def valid_cellphone?
          cellphone.present?
        end
      end
    end
  end
end
