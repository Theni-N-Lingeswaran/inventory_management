Rails.application.routes.draw do
  devise_for :users, controllers: { sessions: 'users/sessions' }, path: '', path_names: { sign_in: 'login', sign_out: 'logout', password: 'reset_password', confirmation: 'verification', unlock: 'unblock', registration: 'register', sign_up: '' }

  devise_scope :user do
    get "logout", to: "devise/sessions#destroy"
  end

  root to: 'dashboard#check_user_home'
  resources :customers

  get '/admin_home/:token', :to => 'dashboard#index', :as => 'admin_home'
  get '/employee_home/:token', :to => 'dashboard#index', :as => 'employee_home'

  get '/home/:token', :to => 'customers#index', :as => 'customer_home'
  get '/all_customers_details/:token', :to => 'customers#get_all_customer_data'
  get '/manage_customers/:token', :to => 'customers#show_customers', :as => 'manage_customers'

  get '/link_company/:token', :to => 'settings#link_customer', :as => 'company_details'
  get '/my_profile/:token', :to => 'settings#user_profile', :as => 'user_details'
  patch '/my_profile/:token', :to => 'settings#update_user_profile', :as => 'update_user_details'
  get '/company_profile/:token', :to => 'settings#company_profile', :as => 'company_profile'
  patch '/company_profile/:token', :to => 'settings#company_profile', :as => 'update_company_profile'
  get '/settings/:token', :to => 'settings#all_settings', :as => 'settings_home'
  get '/profile_settings/:token', :to => 'settings#all_profile', :as => 'profile_settings_home'
  get '/manage_users/:token', :to => 'settings#show_users', :as => 'manage_users'
  get '/get_sub_categories/:token', :to => 'settings#get_sub_categories'
  get '/manage_categories/:token', :to => 'settings#show_categories', :as => 'manage_categories'
  get '/manage_invoices/:token', :to => 'settings#show_invoices', :as => 'manage_invoices'
  post '/update_category_status/:token', :to => 'settings#update_category_status'

  get '/manage_complaints/:token', :to => 'complaints#index', :as => 'manage_complaints'
  get '/manage_products/:token', :to => 'complaints#show_products', :as => 'manage_products'
  get '/new_complaint/:token', :to => 'complaints#new', :as => 'new_complaint'
  post '/new_complaint/:token', :to => 'complaints#create', :as => 'create_complaint'
  get '/new_product/:token', :to => 'complaints#new_product', :as => 'new_product'
  post '/new_product/:token', :to => 'complaints#create_product', :as => 'create_product'
  
  post '/update_product_status/:token', :to => 'complaints#update_product_status'
  post '/update_complaint_status/:token', :to => 'complaints#update_complaint_status'
  get '/get_customers_products/:token', :to => 'complaints#get_customers_products'

  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
