module Auth
  class RegistrationsController < Devise::RegistrationsController
    before_action :configure_sign_up_params, only: [:create]

    # GET /resource/sign_up
    # def new
    #   super
    # end

    # POST /resource
    def create
      build_resource(sign_up_params)
      resource.save
      if resource.persisted?
        render json: {
          data: { success: true }
        }, status: :ok
      else
        render json: { error: resource.errors.full_messages.first }, status: :forbidden
      end
    end

    private

    def configure_sign_up_params
      devise_parameter_sanitizer.permit(
        :sign_up, keys: %i[email]
      )
    end
  end
end
