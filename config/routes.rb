Rails.application.routes.draw do

  get 'charges/create'

  get 'charges/new'

  resources :wikis

  devise_for :users, controllers: {
    sessions: 'users/sessions'
  }
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root "welcome#index"
end
