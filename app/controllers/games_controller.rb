class GamesController < ApplicationController
  before_action :set_room

  # NOTE: AJAX のみを想定
  def create
    @room.create_game!

    render json: @game
  end

  private

  def set_room
    @room = Room.find(params[:room_id])
  end
end
