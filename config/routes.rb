Rails.application.routes.draw do
  mount Redactor2Rails::Engine => '/redactor2_rails'
  mount RedactorRails::Engine => '/redactor_rails'
  devise_for :users
  resources :cities
  resources :votes
  root to: "votes#index"
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
