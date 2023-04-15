require 'rails_helper'

RSpec.describe Auth::RegistrationsController, type: [:controller, :devise_controller] do
  describe 'POST #create' do
    let(:valid_params) do
      {
        email: 'test@example.com',
        password: 'password',
        password_confirmation: 'password'
      }
    end

    context 'when the user signs up with valid parameters' do
      it 'creates a new user' do
        expect do
          post :create, params: { user: valid_params }
        end.to change { User.count }.by(1)
      end

      it 'returns a successful response' do
        post :create, params: { user: valid_params }
        expect(response).to have_http_status(:ok)
      end
    end

    context 'when the user signs up with invalid parameters' do
      let(:invalid_params) { valid_params.merge(email: '') }

      it 'does not create a new user' do
        expect do
          post :create, params: { user: invalid_params }
        end.not_to change { User.count }
      end

      it 'returns an error response' do
        post :create, params: { user: invalid_params }
        expect(response).to have_http_status(:forbidden)
      end
    end
  end
end
