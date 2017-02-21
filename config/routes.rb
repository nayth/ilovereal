Rails.application.routes.draw do


  resources :categories
  resources :posts, only: [:show]
  devise_for :users
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  namespace :admin do
    get '', to: 'dashboard#index', as: '/'
    resources :posts
    resources :categories
  end



  root 'home#show'
end
