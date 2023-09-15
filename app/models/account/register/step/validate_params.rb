module Account
  module Register
    module Step
      class ValidateParams < Micro::Case::Strict
        attributes :customer_id, :agency_id, :account_type

        def call!
          errors = validate_params

          return Success(result: attributes) if errors.empty?

          Failure(:invalid_attributes, result: { errors: })
        end

        private

        def validate_params
          errors = []
          errors << 'O tipo de conta informado não é permitido' unless Account::Record.account_types.key?(account_type)
          errors << 'O id do usuário não está presente' if customer_id.nil? || customer_id.blank?
          errors << 'O id da agência não está presente' if agency_id.nil? || agency_id.blank?

          errors
        end
      end
    end
  end
end
