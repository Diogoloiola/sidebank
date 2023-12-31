module Transaction
  module Transfer
    module Create
      class Flow < Micro::Case::Strict
        attributes :account_origin_id, :account_destiny_id, :value

        def call!
          call(Transaction::Transfer::Create::Step::ValidateParams)
            .then(Transaction::Transfer::Create::Step::Persist)
            .then(Transaction::Transfer::Create::Step::WithdrawalOrigin)
            .then(Transaction::Transfer::Create::Step::DepositDestiny)
        end
      end
    end
  end
end
