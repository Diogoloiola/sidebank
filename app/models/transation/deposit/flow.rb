module Transation
  module Deposit
    class Flow < Micro::Case::Strict
      attributes :origin_id, :value

      def call!
        call(Step::ValidateParams)
          .then(Transation::Deposit::Step::Persit)
          .then(Transation::Deposit::Step::UpdateAccount)
      end
    end
  end
end
