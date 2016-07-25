Rails.application.routes.draw do
  root 'welcome#index'

  get 'about' => 'welcome/about'

  devise_for :users
end
