Rails.application.routes.draw do
  root 'categories#index'
  resources :articles do
    resources :votes, only: %i[create destroy]
  end
  resources :categories, except: %i[edit update destroy]
  resources :users, except: [:new]
  get 'signup', to: 'users#new'
  get 'login', to: 'sessions#new'
  post 'login', to: 'sessions#create'
  delete 'logout', to: 'sessions#destroy'
  get 'my_favorites', to: 'articles#favorites'
end
