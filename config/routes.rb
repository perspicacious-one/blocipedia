Rails.application.routes.draw do

  resources :charges, only: [:new, :create]

  resources :wikis do
    post "user/:id", to: "wikis#add_collaborator"

    resources :collaborators, only: [:new, :destroy] 
  end

  devise_for :users, controllers: {
    sessions: 'users/sessions'
  }
  devise_scope :user do
    patch "user_upgrade" => "users/registrations#upgrade"
    patch "user_downgrade" => "users/registrations#downgrade"
  end


  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root "welcome#index"
end
