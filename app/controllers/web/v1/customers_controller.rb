module Web
  module V1
    class CustomersController < ApplicationController
      def create
        result = Customer::Create::Register.call(customer_params.to_hash)

        if result.success?
          @customer = result.data[:customer]
          render :show, status: :created
        else
          render json: { errors: result.data[:errors] }, status: :unprocessable_entity
        end
      end

      private

      def customer_params
        return {} unless params.key?(:customer)

        params.require(:customer).permit(:name, :email, :cpf, :birthdate, :cellphone)
      end
    end
  end
end
