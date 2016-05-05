class MessagesChannel < ApplicationCable::Channel
  def follow(data)
    stop_all_streams
    @room = Room.find(data['room_id'])

    if @room
      @room.join_user!(current_user) unless @room.member?(current_user)
      stream_from "rooms:#{@room.id}:messages"
      stream_from "rooms:#{@room.id}:users:#{current_user.id}"
    end
  end

  def unsubscribed
    @room.leave_user!(current_user) if @room.try(:member?, current_user)
  end

  def unfollow
    stop_all_streams
  end
end
