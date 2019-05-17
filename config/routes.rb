Rails.application.routes.draw do
  
  resources :answers
  resources :results
  mount Ckeditor::Engine => '/ckeditor'
  devise_for :users, path: 'auth', path_names: { sign_in: 'login', sign_out: 'logout', password: 'secret', 
  	confirmation: 'verification', unlock: 'unblock', registration: 'register', sign_up: 'sign_up' },
  	controllers:{omniauth_callbacks: "users/omniauth_callbacks", registrations: 'users/registrations'}

  root 'home#index'

  resources :users, only: [:update, :edit, :show] do
  	resources :qbanks do
  		collection { post :import }
  	end
    resources :tests do 
      resources :test_qbanks, except: [:edit, :update, :show]
    end
    get "tests/:id/details", param: :id, :controller => 'tests', :action => 'details'
    get "tests/:id/export_pdf", param: :id, :controller => 'tests', :action => 'export_pdf'
  end
  
  resources :users, only: [:index], path: 'administration/users'
  resources :users, only: [:destroy]
  resources :subjects, path: 'administration/subjects'
  resources :categories, path: 'administration/categories'

  resources :administration, only: [:index, :update]

  put "qbanks/delete/:id", param: :id,:controller => 'qbanks', :action => 'delete' 
  patch "qbanks/delete/:id", param: :id,:controller => 'qbanks', :action => 'delete' 
  put "qbanks/accepted/:id", param: :id,:controller => 'qbanks', :action => 'accepted' 
  patch "qbanks/accepted/:id", param: :id,:controller => 'qbanks', :action => 'accepted'
  put "qbanks/recover/:id", param: :id,:controller => 'qbanks', :action => 'recover' 
  patch "qbanks/recover/:id", param: :id,:controller => 'qbanks', :action => 'recover'

  get "qbanks/download_file_excel_sample"
  get "administration/accept_qbank"
  get "administration/qbank_deleted"

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
