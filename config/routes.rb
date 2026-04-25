Rails.application.routes.draw do
  get "pages/home"
  get "manifest" => "rails/pwa#manifest", as: :pwa_manifest, format: :json
  get "service-worker" => "rails/pwa#service_worker", as: :pwa_service_worker
  devise_for :users
  patch "update_currency", to: "users/registrations#update_currency", as: :update_currency
  resources :expenses do
    member do
      get :confirm_destroy
    end
  end
  resources :subscriptions do
    member do
      get :confirm_destroy
    end
  end
  root "pages#home"
end
