Rails.application.routes.draw do
  devise_for :users
  root 'chats#index'
  resources :chats, only: [:index]
  resources :chat_groups, only: [:new]
end
