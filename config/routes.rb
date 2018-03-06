Rails.application.routes.draw do

<<<<<<< HEAD
=======
  resources :charges, only: [:new, :create]

>>>>>>> refs/heads/story-5-seeding-data
  resources :wikis

  devise_for :users, controllers: {
    sessions: 'users/sessions'
  }
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root "welcome#index"
end
