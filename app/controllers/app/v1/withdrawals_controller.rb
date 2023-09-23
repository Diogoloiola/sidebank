module App
  module V1
    class WithdrawalsController < ApiController
      before_action :set_user
      before_action :set_withdrawal, only: %i[show]

      def index
        @pagy, @withdrawals = pagy(Transaction::Record.filter(permitted_params),
                                   page: params[:page], items: params[:per_page])
      end

      def show; end

      def create
        result = Transaction::Withdrawal::Flow.call(withdrawals_params.to_hash)

        if result.success?
          @withdrawal = result.data[:transaction]
          render :show, status: :created
        else
          render json: { errors: result.data[:errors] }, status: :unprocessable_entity
        end
      end

      private

      def set_withdrawal
        @withdrawal = Transaction::Record.find(params[:id])
      end

      def set_user
        @user = current_customer_record
      end

      def permitted_params
        params.permit(:account_origin_id).merge(transaction_type: :saque)
      end

      def withdrawals_params
        return {} unless params.key?(:withdrawal)

        params.require(:withdrawal).permit(:value, :account_origin_id)
      end
    end
  end
end
