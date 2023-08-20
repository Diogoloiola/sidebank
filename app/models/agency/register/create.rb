module Agency
  module Register
    class Create < Micro::Case::Strict
      attributes :name

      def call! # rubocop:disable Metrics/MethodLength
        name = sanitize_params
        code = generate_code

        errors = validate_params(name, code)

        if errors.any?
          Failure(:invalid_attributes, result: { errors: })
        else
          agency = Agency::Record.new(name:, code:)

          if agency.save!
            Success result: { agency: }
          else
            Failure :error, result: {
              errors: customer.errors.messages.joins(', ')
            }
          end
        end
      end

      private

      def sanitize_params
        name.gsub(/[^a-zA-Z\s]/, '')
      end

      def generate_code
        loop do
          code = rand(36**6).to_s(36).upcase
          record = Agency::Record.find_by(code:)

          return code if record.nil?
        end
      end

      def validate_params(name, code)
        errors = []

        errors << 'O nome da agência deve ter no minimo 3 caracters' if name.size < 3
        errors << 'O nome de agência deve ter no máximo 40 letras' if name.size > 40
        errors << 'O código deve ter quatro dígitos' if code.size < 4

        errors
      end
    end
  end
end
