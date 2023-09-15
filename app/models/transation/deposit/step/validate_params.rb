module Transation
  module Deposit
    module Step
      class ValidateParams < Micro::Case::Strict
        attributes :origin_id, :value

        def call!
          errors = validate_params

          return Success(result: attributes) if errors.empty?

          Failure(:invalid_attributes, result: { errors: })
        end

        private

        def validate_params
          errors = []

          errors << ['O valor não poder ser negativo'] if value.negative?

          errors
        end
      end
    end
  end
end
