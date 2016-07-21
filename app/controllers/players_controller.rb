class PlayersController < ApplicationController
  before_action :set_player
  before_action :valid_player

  def reset
    hands = Hand.where(id: params['hands'])
    @player.reset_hands!(hands)

    @player.game.room.messages.create(user: @player.user, content: "#{@player.name}さんが#{params['hands'].size}枚のリセットを行いました。")

    render status: :ok, json: @player.hands.select(%i(id char)).order(:id)
  end

  private

  def set_player
    @player = Player.find(params[:id])
  end

  def valid_player
    raise ActionController::ParameterMissing if @player.user != current_user
  end
end
