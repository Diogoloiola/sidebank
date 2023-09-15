module Transaction
  module Deposit
    class Flow < Micro::Case::Strict
      attributes :origin_id, :value

      def call!
        call(Step::ValidateParams)
          .then(Transaction::Deposit::Step::Persist)
          .then(Transaction::Deposit::Step::UpdateAccount)
      end
    end
  end
end
