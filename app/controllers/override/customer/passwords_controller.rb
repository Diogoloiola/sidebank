module Override
  module Customer
    class PasswordsController < DeviseTokenAuth::PasswordsController
      def create
        @resource = find_resource(:cpf, params[:cpf])
        if @resource
          validate_last_password_reset
          yield @resource if block_given?

          send_reset_password_instructions

          render_response
        else
          render_not_found_error
        end
      end

      def update # rubocop:disable Metrics/AbcSize, Metrics/CyclomaticComplexity, Metrics/MethodLength,Metrics/PerceivedComplexity
        if require_client_password_reset_token? && resource_params[:reset_password_token]
          @resource = resource_class.with_reset_password_token(resource_params[:reset_password_token])
          return render_update_error_unauthorized unless @resource

          @token = @resource.create_token
        else
          @resource = set_user_by_token
        end

        return render_update_error_unauthorized unless @resource

        unless password_resource_params[:password] && password_resource_params[:password_confirmation]
          return render_update_error_missing_password
        end

        return render_update_error unless @resource.send(resource_update_method, password_resource_params)

        @resource.allow_password_change = false if recoverable_enabled?
        @resource.save!

        yield @resource if block_given?
        render_update_success
      end

      def find_resource(field, value)
        resource_class.dta_find_by(field => value, 'provider' => 'cpf')
      end

      def validate_last_password_reset
        if @resource.reset_password_sent_at.present? && @resource.reset_password_sent_at + 5.minutes > Time.zone.now
          render_create_error 'O reset de senha já foi solicitado, aguarde alguns minutos para solicitar novamente.'
        end
      end

      def send_reset_password_instructions
        @resource.send_reset_password_instructions(email: @resource.email, provider: 'email',
                                                   redirect_url: @redirect_url,
                                                   client_config: params[:config_name])
      end

      def render_response
        if @resource.errors.empty?
          render_create_success
        else
          render_create_error @resource.errors
        end
      end
    end
  end
end
