Rails.application.routes.draw do
  mount Rswag::Ui::Engine => '/api-docs'
  mount Rswag::Api::Engine => '/api-docs'

  mount_devise_token_auth_for 'Customer::Record', at: 'auth/v1/customer', controllers: {
    passwords: 'override/customer/passwords',
    sessions: 'override/customer/sessions'
  }

  draw :web
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"
end
