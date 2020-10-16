Rails.application.routes.draw do
  root 'static_pages#home'
  get    '/top',    to: 'static_pages#top'
  get    '/signup', to: 'users#new'
  get    '/login',  to: 'sessions#new'
  post   '/login',  to: 'sessions#create'
  delete '/logout', to: 'sessions#destroy'
  post '/gest_login', to: 'gest_login#new_gest'
  resources :users
  resources :requests, only: [:index, :show, :new, :create, :destroy] do
    resources :comments, only: [:create, :destroy]
  end
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
