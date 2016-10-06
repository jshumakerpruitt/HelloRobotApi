Rails.application.routes.draw do
  get 'chatroom_memberships/create'

  get 'chatroom_membership/create'

  get 'messages/create'

  get 'chatroom_users/create'

  get 'chatroom_users/destroy'

  post 'user_token' => 'user_token#create'
  delete 'user_token' => 'users#logout_all'

  get 'verify' => 'users#verify'

  get 'random' => 'users#random'

  get 'current_user' => 'users#get_current_user'

  resources :users, except: [:new, :edit]
  resources :user_likes, only: [:create, :destroy, :show, :index]
  resources :chatrooms, only: [:create, :destroy, :show]
  resources :chatroom_users, only: [:create, :destroy]
  resources :messages, only: [:create]
  resources :chatroom_memberships, only: [:create]
  root 'users#index'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
