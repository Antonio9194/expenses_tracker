Rails.application.routes.draw do
  devise_for :users
  patch "update_currency", to: "users/registrations#update_currency", as: :update_currency
  resources :expenses
  resources :subscriptions
  root "expenses#index"
end
