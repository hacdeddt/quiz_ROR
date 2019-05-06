Rails.application.routes.draw do
  devise_for :users, path: 'auth', path_names: { sign_in: 'login', sign_out: 'logout', password: 'secret', 
  	confirmation: 'verification', unlock: 'unblock', registration: 'register', sign_up: 'sign_up' },
  	controllers:{omniauth_callbacks: "users/omniauth_callbacks", registrations: 'users/registrations'}

  root 'home#index'
  resources :users, only: [:update, :edit, :show]
  patch 'users/:id', to: "users#update_image"
  put 'users/:id', to: "users#update_image"
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
