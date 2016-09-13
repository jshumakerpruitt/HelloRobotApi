Rails.application.routes.draw do
  post 'user_token' => 'user_token#create'
  delete 'user_token' => 'users#logout_all'
  get 'verify' => 'users#verify'
  resources :users, except: [:new, :edit]
  resources :user_likes, only: [:create,:destroy, :show, :index]
  root 'users#index'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
