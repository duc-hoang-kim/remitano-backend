module Auth
  class ConfirmationsController < Devise::ConfirmationsController
    def show
      self.resource = resource_class.confirm_by_token(params[:confirmation_token])
      resource.save
      if resource.errors.empty?
        redirect_to ENV['REMITANO_FE_CLIENT']
      else
        render json: { error: resource.errors.full_messages.first }, status: :forbidden
      end
    end
  end
end
