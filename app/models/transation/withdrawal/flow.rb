module Transation
  module Withdrawal
    class Flow < Micro::Case::Strict
      attributes :origin_id, :value

      def call!
        call(Transation::Withdrawal::Step::ValidateParams)
          .then(Transation::Withdrawal::Step::Persit)
          .then(Transation::Withdrawal::Step::UpdateAccount)
      end
    end
  end
end
