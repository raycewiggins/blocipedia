Rails.application.routes.draw do
  root 'welcome#index'
  get 'about' => 'welcome#about'

  get 'users/update'
  get 'charges/create'

  resources :collaborators, only: [:show]
  resources :wikis
  resources :charges

  devise_for :users, :skip => [:sessions]
  as :user do
    get 'signin' => 'devise/sessions#new', :as => :new_user_session
    post 'signin' => 'devise/sessions#create', :as => :user_session
    delete 'signout' => 'devise/sessions#destroy', :as => :destroy_user_session
  end
end
