class MessagesChannel < ApplicationCable::Channel
  def follow(data)
    stop_all_streams
    stream_from "rooms:#{data['room_id'].to_i}:messages"
    stream_from "rooms:#{data['room_id'].to_i}:users:#{current_user.id}"
  end

  def unfollow
    stop_all_streams
  end
end
