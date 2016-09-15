Rails.application.routes.draw do
  devise_for :users

  root 'welcome#index'
  get 'about' => 'welcome#about'

  get 'users/update'
  get 'charges/create'

  resources :collaborators, only: [:show]
  resources :wikis
  resources :charges
end
