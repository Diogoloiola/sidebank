module Agency
  module Register
    module Step
      class SanitizeParams < Micro::Case::Strict
        attributes :name

        def call!
          Success(result: { name: name.gsub(/[^a-zA-Z\s]/, '') })
        end
      end
    end
  end
end
