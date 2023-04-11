class ApplicationController < ActionController::API
  before_action :authenticate_user!

  private

  def authenticate_user!
    return if user_signed_in?

    render json: { error: "Unauthorize" }, status: :unauthorized
  end
end
