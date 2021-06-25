Rails.application.routes.draw do
  get "chat_rooms/index"
  get "chat_rooms/new"
  get "chat_rooms/create"
  devise_for :users

  resources :chat_rooms, only: [:new, :create, :show, :index]
  root "chat_rooms#index"

end
