Rails.application.routes.draw do
  # Serve websocket cable requests in-process
  mount ActionCable.server => '/cable'

  resources :sessions, only: %i(new create)
  resources :rooms do
    # NOTE: '/rooms/messages' に [message][selected_hand_id] というパラメータが付与されているときだけ hands#play アクションを呼び出す。
    #       それ以外のときは messages#create アクションを呼び出す。
    #       「一つに URL に対して、一つのリソースの操作」というのが Web のお約束だが、
    #       画面側としてはメッセージの投稿と手札のプレイを区別しない方が楽だというワガママがあるため、このようにした。
    post :messages, to: 'hands#play', constraints: ->(r) { r.params.dig(:message, :selected_hand_id).present? }, as: 'play_hand'
    post :messages, to: 'messages#create'

    resources :games,    only: %i(create)
  end

  root 'rooms#index'
end
