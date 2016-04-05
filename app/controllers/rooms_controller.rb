class RoomsController < ApplicationController
  before_action :set_room, only: %i(show)

  def index
    @rooms = Room.order(:id)
  end

  def show
    @room.attendances.create(user: current_user) unless @room.member?(current_user)
  end

  private

  def set_room
    @room = Room.includes(:members, messages: :user).find(params[:id])
  end
end
