Rails.application.routes.draw do
  devise_for :users, path: 'auth', path_names: { sign_in: 'login', sign_out: 'logout', password: 'secret', 
  	confirmation: 'verification', unlock: 'unblock', registration: 'register', sign_up: 'sign_up' },
  	controllers:{omniauth_callbacks: "users/omniauth_callbacks"}

  root 'home#index'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
