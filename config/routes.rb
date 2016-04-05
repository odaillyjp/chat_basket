Rails.application.routes.draw do
  resources :sessions, only: %i(new create)
  resources :rooms do
    resources :messages, only: %i(create)
    resources :games,    only: %i(create)
  end

  root 'rooms#index'
end
