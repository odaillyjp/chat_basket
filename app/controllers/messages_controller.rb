class MessagesController < ApplicationController
  before_action :set_room

  # NOTE: AJAX のみを想定
  def create
    @comment = @room.messages.build(message_params)
    @comment.user = @current_user
    @comment.save!

    render @comment
  end

  private

  def set_room
    @room = Room.find(params[:room_id])
  end

  def message_params
    params.require(:message).permit(:content)
  end
end
