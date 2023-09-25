module App
  module V1
    class TransfersController < ApplicationController
      before_action :set_transfer, only: %i[show refund]

      def index
        @pagy, @deposits = pagy(Transaction::Record.filter(permitted_params),
                                page: params[:page], items: params[:per_page])
      end

      def show; end

      def refund
        result = Transaction::Transfer::Refund::Flow.call(transaction_id: @transfer.id)

        if result.success?
          @transfer = result.data[:transaction]
          render :show, status: :created
        else
          render json: { errors: result.data[:errors] }, status: :unprocessable_entity
        end
      end

      def create
        result = Transaction::Transfer::Create::Flow.call(transfer_params.to_hash)

        if result.success?
          @transfer = result.data[:transaction]
          render :show, status: :created
        else
          render json: { errors: result.data[:errors] }, status: :unprocessable_entity
        end
      end

      private

      def set_transfer
        @transfer = Transaction::Record.find(params[:id])
      end

      def permitted_params
        params.permit(:account_origin_id).merge(transaction_type: :transferencia)
      end

      def transfer_params
        return {} unless params.key?(:transfer)

        params.require(:transfer).permit(:account_origin_id, :account_destiny_id, :value)
      end
    end
  end
end
