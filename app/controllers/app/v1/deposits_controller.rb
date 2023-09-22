module App
  module V1
    class DepositsController < ApiController
      before_action :set_user
      before_action :set_deposit, only: %i[show]

      def index
        @pagy, @deposits = pagy(Transaction::Record.where(origin_id: params[:account_id], transaction_type: :deposito),
                                page: params[:page], items: params[:per_page])
      end

      def show; end

      def create
        result = Transaction::Deposit::Flow.call(deposit_params.to_hash)

        if result.success?
          @deposit = result.data[:transaction]
          render :show, status: :created
        else
          render json: { errors: result.data[:errors] }, status: :unprocessable_entity
        end
      end

      private

      def set_deposit
        @deposit = Transaction::Record.find(params[:id])
      end

      def set_user
        @user = current_customer_record
      end

      def deposit_params
        return {} unless params.key?(:deposit)

        params.require(:deposit).permit(:value, :origin_id)
      end
    end
  end
end
