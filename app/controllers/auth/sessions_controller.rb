module Auth
  class SessionsController < Devise::SessionsController
    skip_before_action :authenticate_user!, except: :show

    def show
      render json: { data: { user: current_user } }, status: :ok
    end

    def create
      if session[:current_user_id]
        return render json: { error: 'User have already logged in' }, status: :forbidden
      end

      self.resource = warden.authenticate!(auth_options)
      sign_in(resource_name, resource)

      session[:current_user_id] = current_user.id

      render json: {
        data: { user: current_user }
      }, status: :created
    end

    def destroy
      signed_out = (Devise.sign_out_all_scopes ? sign_out : sign_out(resource_name))

      render json: {
        data: { success: true }
      }, status: :ok
    end

    private

    def verify_signed_out_user
      if all_signed_out?
        render json: { error: 'User have already logged out.' }, status: :forbidden
      end
    end
  end
end
