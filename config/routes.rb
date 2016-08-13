Rails.application.routes.draw do

  devise_for :users
  root 'movies#index'
  resources :movies
  
  get 'speed' => 'movies#speed' # just doing some speed test

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
