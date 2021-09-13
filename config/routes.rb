Rails.application.routes.draw do
  mount LetterOpenerWeb::Engine, at: "/letter_opener" if Rails.env.development?
  devise_for :users
  root to: 'books#index'
  resources :books
  resources :users, only: %i(index show) do
    resources :followings, controller: 'users/followings', only: %i(index)
    resources :followers, controller: 'users/followers', only: %i(index)
  end
  resources :relationships, only: %i(create destroy)
end
