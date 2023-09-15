module Transaction
  module Transfer
    class Flow < Micro::Case::Strict
      attributes :origin_id, :destiny_id, :value

      def call!
        call(Transaction::Transfer::Step::ValidateParams)
          .then(Transaction::Transfer::Step::Persist)
          .then(Transaction::Transfer::Step::WithdrawalOrigin)
          .then(Transaction::Transfer::Step::DepositDestiny)
      end
    end
  end
end
