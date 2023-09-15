module Transation
  module Withdrawal
    module Step
      class ValidateParams < Micro::Case::Strict
        attributes :origin_id, :value

        def call!
          return Success(result: attributes) if permit_withdrawal?

          Failure(:invalid_attributes, result: { errors: ['Erro: Não é possivél fazer o saque'] })
        end

        private

        def permit_withdrawal?
          account = Account::Record.find(origin_id)

          (account.balance - value).positive?
        end
      end
    end
  end
end
