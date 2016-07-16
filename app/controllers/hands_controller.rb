class HandsController < ApplicationController
  before_action :set_room
  before_action :valid_room

  # NOTE: AJAX のみを想定
  def play
    hand = Hand.find(message_params['selected_hand_id'])
    current_game = @room.current_game

    begin
      # NOTE: 単語の検証を行う
      current_game.play_card!(current_user, hand, message_params['content'])
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

    head :ok
  end

  private

  def set_room
    @room = Room.find(params[:room_id])
  end

  def valid_room
    raise ActionController::ParameterMissing unless @room.playing_game?
  end

  def message_params
    params.require(:message).permit(:content, :selected_hand_id)
  end
end
