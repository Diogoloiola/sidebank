module App
  module V1
    class MeController < ApiController
      before_action :set_me, only: %i[show update]

      def show; end

      def update
        if @me.update(me_params)
          render :show, status: :ok
        else
          render json: @me.errors, status: :unprocessable_entity
        end
      end

      def set_me
        @me = current_customer_record
      end

      def me_params
        params.requie(:me).permit(:name, :email)
      end
    end
  end
end
