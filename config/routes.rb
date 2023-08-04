Rails.application.routes.draw do
  devise_for :users
  get 'dashboard', to: 'pages#dashboard'
  post 'prompts', to: 'prompts#create'
  get 'home/index'
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html
  post 'csv/import' => 'csv#import'

  # Defines the root path route ("/")
  root 'home#index'
end
