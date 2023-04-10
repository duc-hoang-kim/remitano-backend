module Auth
  class SessionsController < Devise::SessionsController
    def create
      if session[:current_user_id]
        return render json: { error: 'User have already logged in' }, status: :forbidden
      end

      self.resource = warden.authenticate!(auth_options)
      set_flash_message!(:notice, :signed_in)
      sign_in(resource_name, resource)

      if current_user
        session[:current_user_id] = current_user.id

        render json: {
          data: { user: current_user }
        }, status: :ok
      else
        render json: { error: 'Wrong email or password' }, status: :unauthorized
      end
    end

    def destroy
      signed_out = (Devise.sign_out_all_scopes ? sign_out : sign_out(resource_name))

      if signed_out
        render json: {
          data: { success: true }
        }, status: :ok
      else
        render json: { error: 'User have already logged out' }, status: :forbidden
      end
    end
  end
end
