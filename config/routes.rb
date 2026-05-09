Rails.application.routes.draw do
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  devise_for :users
  root 'chat_groups#index'
  resources :chat_groups, except: %i[show destroy] do
    resources :messages, only: %i[index create]
  end
  resources :users, only: :index
end
