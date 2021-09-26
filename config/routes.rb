Rails.application.routes.draw do
  devise_for :users, controllers: { sessions: 'users/sessions' }, path: '', path_names: { sign_in: 'login', sign_out: 'logout', password: 'reset_password', confirmation: 'verification', unlock: 'unblock', registration: 'register', sign_up: '' }

  devise_scope :user do
    get "logout", to: "devise/sessions#destroy"
  end

  root to: 'dashboard#index'
  resources :customers

  get '/:token', :to => 'customers#index', :as => 'customer_view'
  get '/get_all_customer_details', :to => 'customers#get_all_customers'

  get '/all_settings/:token', :to => 'settings#index'
  get '/user_details/:token', :to => 'settings#user_profile', :as => 'user_details'
  get '/link_company/:token', :to => 'settings#link_customer', :as => 'company_details'

  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
