Rails.application.routes.draw do
  get 'kaltes/new'
  get 'kaltes/show'
  get 'kaltes/edit'
  root to: 'customers#index'
  resources :customers, except: [:delete]
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
