Rails.application.routes.draw do
  get "manifest" => "rails/pwa#manifest", as: :pwa_manifest, format: :json
  get "service-worker" => "rails/pwa#service_worker", as: :pwa_service_worker
  devise_for :users
  patch "update_currency", to: "users/registrations#update_currency", as: :update_currency
  get "confirm_cancel_account", to: "users/registrations#confirm_cancel", as: :confirm_cancel_account
  resources :expenses do
    collection do
      get :history
    end
    member do
      get :confirm_destroy
    end
  end
  resources :subscriptions do
    member do
      get :confirm_destroy
    end
  end
  resource :budget do
      patch :toggle
  end
  root "pages#home"
end
