module Account
  module Register
    class Create < Micro::Case::Strict
      attributes :customer_id, :agency_id, :account_type

      def call! # rubocop:disable Metrics/AbcSize, Metrics/MethodLength
        errors = validate_params

        return Failure(:invalid_attributes, result: { errors: }) if errors.present?

        code = generate_code

        account = Account::Record.new(
          customer_id:,
          agency_id:,
          account_type:,
          opening_date: Time.now,
          code:
        )

        if account.save!
          Success(result: { account: })
        else
          Failure(:errors, result: { errors: [account.errors.full_messages.join(', ')] })
        end
      rescue StandardError => e
        Failure(:errors, result: { errors: ["Ocorreu um erro: #{e.message}"] })
      end

      private

      def validate_params
        errors = []
        errors << 'O tipo de conta informado não é permitido' unless Account::Record.account_types.key?(account_type)
        errors << 'O id do usuário não está presente' if customer_id.nil? || customer_id.blank?
        errors << 'O id da agência não está presente' if agency_id.nil? || agency_id.blank?

        errors
      end

      def generate_code
        loop do
          code = rand(36**6).to_s(36).upcase
          return code unless Account::Record.exists?(code:)
        end
      end
    end
  end
end
