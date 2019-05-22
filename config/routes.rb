Rails.application.routes.draw do
  
  mount Ckeditor::Engine => '/ckeditor'
  devise_for :users, path: 'auth', path_names: { sign_in: 'login', sign_out: 'logout', password: 'secret', 
  	confirmation: 'verification', unlock: 'unblock', registration: 'register', sign_up: 'sign_up' },
  	controllers:{omniauth_callbacks: "users/omniauth_callbacks", registrations: 'users/registrations',
                  sessions: 'users/sessions'}

  root 'home#index'

  resources :users, only: [:update, :edit, :show] do
  	resources :qbanks do
  		collection { post :import }
  	end
    resources :tests do 
      resources :test_qbanks, except: [:edit, :update, :show]
      resources :results, path: :examine, only: [:create, :show] do
        resources :answers, only: [:show, :create]
      end
      get "results/:id/result_details", param: :id, to: 'results#result_details', as: :results_details
    end
    resources :results, only: [:index, :destroy]
    get "tests/:id/details", param: :id, to:'tests#details', as: :test_details
    get "tests/:id/export_pdf", param: :id, to: "tests#export_pdf", as: :tests_export_pdf, defaults: { format: 'pdf' }
  end

  put "users/banned/:id", param: :id, to: "users#banned", as: :users_banned
  patch "users/banned/:id", param: :id, to: "users#banned"
  put "users/unbanned/:id", param: :id, to: "users#unbanned", as: :users_unbanned
  patch "users/unbanned/:id", param: :id, to: "users#unbanned"
  
  resources :users, only: [:index], path: 'administration/users'
  resources :users, only: [:destroy]
  resources :subjects, path: 'administration/subjects'
  resources :categories, path: 'administration/categories'

  resources :administration, only: [:index, :update]

  put "qbanks/delete/:id", param: :id, to: 'qbanks#delete', as: :qbanks_delete
  patch "qbanks/delete/:id", param: :id,:controller => 'qbanks', :action => 'delete' 
  put "qbanks/accepted/:id", param: :id,:controller => 'qbanks', :action => 'accepted' 
  patch "qbanks/accepted/:id", param: :id,:controller => 'qbanks', :action => 'accepted'
  put "qbanks/recover/:id", param: :id,:controller => 'qbanks', :action => 'recover' 
  patch "qbanks/recover/:id", param: :id,:controller => 'qbanks', :action => 'recover'
  get "qbanks/reversion/:id", param: :id, to: "qbanks#reversion", as: :qbanks_reversion

  get "qbanks/download_file_excel_sample"
  get "administration/accept_qbank"
  get "administration/qbank_deleted"

  put "results/delete/:id", param: :id, to: "results#delete", as: :results_delete
  patch "results/delete/:id", param: :id, to: "results#delete"

  put "tests/delete/:id", param: :id, to: "tests#delete", as: :tests_delete
  patch "tests/delete/:id", param: :id, to: "tests#delete"

  put "categories/delete/:id", param: :id, to: "categories#delete", as: :categories_delete
  patch "categories/delete/:id", param: :id, to: "categories#delete"

  put "subjects/delete/:id", param: :id, to: "subjects#delete", as: :subjects_delete
  patch "subjects/delete/:id", param: :id, to: "subjects#delete"

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
