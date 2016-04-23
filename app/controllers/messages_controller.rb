class MessagesController < ApplicationController
  before_action :set_room

  # NOTE: AJAX のみを想定
  def create
    if params[:message].try(:[], :selected_hand_id).present? && @room.playing_game?
      # NOTE: カードをプレイした時は単語の検証を行う
      # TODO: クライアント側でリクエスト先を変えたい気持ち
      hand = Hand.find(params[:message][:selected_hand_id])
      current_game = @room.current_game

      begin
        current_game.play_card!(current_user, hand, params[:message][:content])
      rescue => e
        Rails.logger.info "game_id=#{current_game.id}, user_id=#{current_user.id}, params=#{params}, error=#{e}"
        ActionCable.server.broadcast "rooms:#{@room.id}:users:#{current_user.id}", alertMessage: e.message
        return
      end

      current_game.reload

      if current_game.playing?
        current_game.broadcast_playing_status_to_players
      else
        current_game.broadcast_gameover_status_to_players
      end
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
