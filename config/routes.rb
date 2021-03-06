Rails.application.routes.draw do
  root to: 'customers#index'
  get "/login", to: "sessions#new"
  post "/login", to: "sessions#create"
  delete "/logout", to: "sessions#destroy"
  resources :users
  resources :customers, except: [:delete]
  resources :customer do
    resources :kaltes, except: [:index]
  end
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
