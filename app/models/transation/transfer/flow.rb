module Transation
  module Transfer
    class Flow < Micro::Case::Strict
      attributes :origin_id, :destiny_id, :value

      def call!
        call(Transation::Transfer::Step::ValidateParams)
          .then(Transation::Transfer::Step::Persit)
          .then(Transation::Transfer::Step::WithdrawalOrigin)
          .then(Transation::Transfer::Step::DepositDestiny)
      end
    end
  end
end
