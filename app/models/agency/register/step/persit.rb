module Agency
  module Register
    module Step
      class Persit < Micro::Case::Strict
        attributes :name

        def call!
          code = generate_code
          agency = Agency::Record.new(name:, code:)

          if agency.save!
            Success result: { agency: }
          else
            Failure :error, result: {
              errors: agency.errors.full_messages.join(', ')
            }
          end
        end

        private

        def generate_code
          loop do
            code = rand(36**6).to_s(36).upcase
            record = Agency::Record.find_by(code:)

            return code if record.nil?
          end
        end
      end
    end
  end
end
