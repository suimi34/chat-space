Rails.application.routes.draw do
  devise_for :users
  root 'chat_groups#index'
  resources :chat_groups, except: %i[show destroy] do
    collection do
      get :user_search
    end
    resources :messages, only: %i[index create]
  end
end
