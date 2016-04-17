class MessagesController < ApplicationController
  before_action :set_room

  # NOTE: AJAX のみを想定
  def create
    if params[:message].try(:[], :selected_hand).present? && @room.playing_game?
      # NOTE: カードをプレイした時は単語の検証を行う
      # TODO: クライアント側でリクエスト先を変えたい気持ち
      @room.current_game.play_card!(@current_user, params[:selected_hand], params[:content])
    else
      # NOTE: それ以外の時はメッセージを保存
      @comment = @room.messages.build(message_params)
      @comment.user = @current_user
      @comment.save!

      render @comment
    end
  end

  private

  def set_room
    @room = Room.find(params[:room_id])
  end

  def message_params
    params.require(:message).permit(:content)
  end
end
