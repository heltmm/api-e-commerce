Rails.application.routes.draw do
  mount_devise_token_auth_for 'User', at: 'auth'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root :to => 'products#index'
  resources :products
  resources :order_items
  resource :cart, only: [:show]
  # resources :charges, only: [:new, :create]
end
