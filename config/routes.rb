Rails.application.routes.draw do

  mount ActionCable.server => '/cable'
  devise_for :users

  resources :chatrooms do
    resource :chatroom_users
    resources :messages
  end

  root 'chatrooms#index'
  get 'chatrooms/index'

  #글 쓰는 액션
  post '/write' => 'chatrooms#write'
  #답글 쓰는 액션
  post '/reply_write' => 'chatrooms#reply_write'
  #이메일 보내는 액션
  post '/email_write' => 'chatrooms#email_write'

  get '/index' => 'chatrooms#index'

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
