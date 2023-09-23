module Transaction
  module Withdrawal
    class Flow < Micro::Case::Strict
      attributes :account_origin_id, :value

      def call!
        call(Transaction::Withdrawal::Step::ValidateParams)
          .then(Transaction::Withdrawal::Step::Persist)
          .then(Transaction::Withdrawal::Step::UpdateAccount)
      end
    end
  end
end
