module Customer
  module Create
    class Register < Micro::Case::Strict
      attributes :name, :email, :cpf, :birthdate, :cellphone

      def call!
        call(ValidateParams)
          .then(Persist)
          .then(SendEmail)
      end
    end
  end
end
