module Transaction
  module Transfer
    module Create
      module Step
        class ValidateParams < Micro::Case::Strict
          attributes :account_origin_id, :account_destiny_id, :value

          def call!
            errors = validate_params

            return Success(result: attributes) if errors.empty?

            Failure(:invalid_attributes, result: { errors: })
          end

          private

          def validate_params
            errors = []
            account_origin = Account::Record.find(account_origin_id)
            account_destiny = Account::Record.find(account_destiny_id)

            errors << 'O valor não poder ser negativo' if value.negative?

            if (account_origin.balance - value).negative?
              errors << 'A conta de origin não tem saldo suficiente para realizar a transferência'
            end

            errors << 'A conta de origem está desativada' unless account_origin.active?

            errors << 'A conta de destino está desativada' unless account_destiny.active?

            errors
          end
        end
      end
    end
  end
end
