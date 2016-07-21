class RoomsController < ApplicationController
  before_action :set_room, only: %i(show)

  def index
    # TODO: 部屋作成機能が実装されるまでは最初の部屋にリダイレクト
    if true
      redirect_to room_path(Room.first)
      return
    end
    # TODO: これ以降は実行されない

    @rooms = Room.order(:id)
  end

  def show
  end

  private

  def set_room
    @room = Room.includes(:members, messages: :user).find(params[:id])
  end
end
