class MessagesChannel < ApplicationCable::Channel
  def follow(data)
    stop_all_streams
    @room = Room.find(data['room_id'])

    if @room
      stream_from "rooms:#{@room.id}:messages"
      stream_from "rooms:#{@room.id}:users:#{current_user.id}"
      @room.join_user!(current_user) unless @room.active_member?(current_user)
    end
  end

  def unsubscribed
    @room.leave_user!(current_user) if @room.try(:active_member?, current_user)
  end

  def unfollow
    stop_all_streams
  end
end
