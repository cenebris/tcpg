Rails.application.routes.draw do
  devise_for :users

  root 'home#welcome'

  namespace :api do
    resources :movies, only: [:index, :show]
  end

  resources :genres, only: :index do
    member do
      get 'movies'
    end
  end

  resources :movies, only: [:index, :show] do
    member do
      get :send_info
    end
    collection do
      get :export
    end
  end
end
