module Customer
  module Create
    class SanatizeParams < Micro::Case::Strict
      attributes :name, :email, :cpf, :birthdate, :cellphone

      def call!
        Success result: {
          name:,
          email:,
          cpf: CPF.new(cpf).formatted,
          birthdate:,
          cellphone:
        }
      end
    end
  end
end
