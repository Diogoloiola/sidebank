module Transaction
  module Register
    class Create < Micro::Case::Strict

      # aqui é onde gera uma transição (no momento em que o usuário da conta origem clica em enviar dinheiro para outra conta)
      # o tipo de transação
      # o valor a enviar
      # (a data pode ser feito pelo servidor)
      # a conta de quem esta enviando
      # a conta para quem está enviando
      # a descrição que o usuário escreveu

      attributes :transaction_type, :value, :origin_id, :destiny_id, :description

      def call!
        errors = validate_params

        return Failure(:invalid_attributes, result: { errors: }) if errors.present?

        origin = Account::Record.find_by(id: origin_id)
        destiny = Account::Record.find_by(id: destiny_id)

        errors = validate_accounts(origin, destiny)

        return Failure(:invalid_accounts, result: { errors: }) if errors.present?

        # https://thoughtbot.com/blog/its-about-time-zones
        date_transaction = Time.current

        transaction = Transaction::Record.new(
          transaction_type:,
          value:,
          date_transaction:,
          origin:,
          destiny:,
          description:
        )

        if transaction.save!
          Success(result: { transaction: })
        else
          Failure(:errors, result: { errors: [transaction.errors.full_messages.join(', ')] })
        end
      rescue StandardError => e
        Failure(:errors, result: { errors: ["Ocorreu um erro: #{e.message}"] })
      end

      private

      def validate_params
        errors = []
        errors << 'O tipo de transação informada não é permitida' unless Transaction::Record.transaction_types.key?(transaction_type)
        errors << 'O id da conta de origem não está presente' if origin_id.nil? || origin_id.blank?
        errors << 'O id da conta de destino não está presente' if destiny_id.nil? || destiny_id.blank?
        errors << 'O valor não pode ser menor que 0' if value <= 0.0
        errors << 'O id da conta de origem não pdoe ser o mesmo da conta destino' if origin_id == destiny_id
        errors
      end

      def validate_accounts(origin, destiny)
        errors = []
        errors << 'O balanço na conta de origem é menor que 0' if origin.balance <= 0.0
        errors
      end
    end
  end
end
