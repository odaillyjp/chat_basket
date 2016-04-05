class RoomsController < ApplicationController
  before_action :set_room, only: %i(show)

  def index
    @rooms = Room.order(:id)
  end

  def show
  end

  private

  def set_room
    @room = Room.includes(messages: :user).find(params[:id])
  end
end
