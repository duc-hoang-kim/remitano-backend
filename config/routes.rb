Rails.application.routes.draw do
  scope :api do
    scope :v1 do
      devise_for :users, defaults: { format: :json }, controllers: {
        sessions: 'auth/sessions',
        registrations: 'auth/registrations',
        confirmations: 'auth/confirmations'
      }, skip: %i[password]
    end
  end

  namespace :api do
    namespace :v1 do
      resources :videos, only: [:index, :create, :destroy]
    end
  end
end
