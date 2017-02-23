Rails.application.routes.draw do
  devise_for :users
  resources :cities
  get 'votes/new/:id' => 'votes#create', as: :create_vote
  get 'votes/new' => 'votes#new', as: :new_vote_path
  root to: "votes#index"
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
