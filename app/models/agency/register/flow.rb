module Agency
  module Register
    class Flow < Micro::Case::Strict
      attributes :name

      def call!
        call(Step::SanitizeParams)
          .then(Step::ValidateParams)
          .then(Step::Persit)
      end
    end
  end
end
