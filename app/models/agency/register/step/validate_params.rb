module Agency
  module Register
    module Step
      class ValidateParams < Micro::Case::Strict
        attributes :name

        def call!
          errors = validate_params

          return Success(result: attributes) if errors.empty?

          Failure(:invalid_attributes, result: { errors: })
        end

        private

        def validate_params
          errors = []

          errors << 'O nome da agência deve ter no minimo 3 caracters' if name.size < 3
          errors << 'O nome de agência deve ter no máximo 40 letras' if name.size > 40

          errors
        end
      end
    end
  end
end
