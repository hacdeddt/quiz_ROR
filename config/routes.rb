Rails.application.routes.draw do
  
  mount Ckeditor::Engine => '/ckeditor'
  devise_for :users, path: 'auth', path_names: { sign_in: 'login', sign_out: 'logout', password: 'secret', 
  	confirmation: 'verification', unlock: 'unblock', registration: 'register', sign_up: 'sign_up' },
  	controllers:{omniauth_callbacks: "users/omniauth_callbacks", registrations: 'users/registrations'}

  root 'home#index'

  resources :users, only: [:update, :edit, :show] do
  	resources :qbanks
  end

  resources :subjects
  resources :categories
  put "qbanks/delete/:id", param: :id,:controller => 'qbanks', :action => 'delete' 
  patch "qbanks/delete/:id", param: :id,:controller => 'qbanks', :action => 'delete' 

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
