Rails.application.routes.draw do
  root "grams#index"

  devise_for :users

  resources :grams

end
