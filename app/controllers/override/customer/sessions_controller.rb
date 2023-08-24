module Override
  module Customer
    class SessionsController < DeviseTokenAuth::SessionsController
      def provider
        super
        'cpf'
      end

      protected

      def render_create_success
        render json: {
          data: {
            email: @resource.email,
            cpf: @resource.cpf,
            name: @resource.name,
            id: @resource.id,
            active: @resource.active
          }
        }
      end
    end
  end
end
