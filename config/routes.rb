Rails.application.routes.draw do
  # Serve websocket cable requests in-process
  mount ActionCable.server => '/cable'

  resources :sessions, only: %i(new create)
  resources :rooms do
    resources :messages, only: %i(create)
    resources :games,    only: %i(create)
  end

  root 'rooms#index'
end
