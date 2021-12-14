Rails.application.routes.draw do
  namespace :twilio_api do
    resources :calls, only: :create
    resource :callback, only: :create
  end
end
