Rails.application.routes.draw do

  get '/events', to: 'releases#events'
  get '/new_event', to: 'releases#new_event'
  post '/create_event', to: 'releases#create_event'
  get '/tree', to: 'releases#tree'
  get '/expand_tree/:company_name', to: 'releases#expand_tree'

  resources :chemicals
  resources :releases
  resources :companies
  resources :facilities
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  root to: 'home#index'
end
