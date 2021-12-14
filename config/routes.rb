Rails.application.routes.draw do
  namespace :twilio_api do
    resources :calls, only: :create
  end
end
