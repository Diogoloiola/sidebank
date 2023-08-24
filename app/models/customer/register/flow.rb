module Customer
  module Register
    class Flow < Micro::Case::Strict
      attributes :name, :email, :cpf, :birthdate, :cellphone

      def call!
        call(Step::ValidateParams)
          .then(Step::SanatizeParams)
          .then(Step::Persist)
          .then(Step::SendEmail)
      end
    end
  end
end
