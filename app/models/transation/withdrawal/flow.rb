module Transation
  module Withdrawal
    class Flow < Micro::Case::Strict
      attributes :origin_id, :value

      def call!
        call(Transation::Withdrawal::Step::ValidateParams)
          .then(Transation::Withdrawal::Step::Persist)
          .then(Transation::Withdrawal::Step::UpdateAccount)
      end
    end
  end
end
