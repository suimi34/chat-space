Rails.application.routes.draw do
  devise_for :users
  root 'chats#index'
  get 'chats/index' => 'chats#index'
end
