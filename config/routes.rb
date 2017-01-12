Rails.application.routes.draw do
  devise_for :users
  root 'chat_groups#index'
  resources :chat_groups, except: [:show, :destroy] do
    member do
      get 'messages'
    end
  end
end
