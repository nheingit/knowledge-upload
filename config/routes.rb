Rails.application.routes.draw do
  get 'pages/dashboard'
  devise_for :users
  post 'prompts', to: 'prompts#create'
  get 'home/index'
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html
  post 'csv/import' => 'csv#import'

  # Defines the root path route ("/")
  root 'home#index'
end
