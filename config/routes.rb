Rails.application.routes.draw do
  get 'users/update'

  get 'charges/create'

  root 'welcome#index'
  get 'about' => 'welcome#about'

  resources :users, only: [:show]
  resources :wikis
  resources :charges
  devise_for :users, :skip => [:sessions]
  as :user do
    get 'signin' => 'devise/sessions#new', :as => :new_user_session
    post 'signin' => 'devise/sessions#create', :as => :user_session
    delete 'signout' => 'devise/sessions#destroy', :as => :destroy_user_session
  end
end
