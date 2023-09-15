module Account
  module Register
    class Flow < Micro::Case::Strict
      attributes :customer_id, :agency_id, :account_type

      def call!
        call(Step::ValidateParams)
          .then(Step::Persist)
      end
    end
  end
end
