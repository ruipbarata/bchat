Rails.application.routes.draw do
  get "home/index"
  get "chat_rooms/index"
  get "chat_rooms/new"
  get "chat_rooms/create"

  get "home/index"
  devise_for :users, controllers: { omniauth_callbacks: "users/omniauth_callbacks" }

  resources :chat_rooms, only: [:new, :create, :show, :index]
  root "home#index"

end
