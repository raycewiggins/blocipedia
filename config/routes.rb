Rails.application.routes.draw do
  get 'users/update'

  get 'charges/create'

  root 'welcome#index'
  get 'about' => 'welcome#about'
  get 'profile' => 'users#show'

  resources :wikis
  resources :charges
  devise_for :users
end
