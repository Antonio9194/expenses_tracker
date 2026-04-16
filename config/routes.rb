Rails.application.routes.draw do
  devise_for :users
  resources :expenses
  resources :subscriptions
  root "expenses#index"
end
