class MessageRelayJob < ApplicationJob
  queue_as :default

  def perform(message)
    ActionCable.server.broadcast "rooms:#{message.room_id}:messages",
      command: 'appendMessage',
      body: MessagesController.render(partial: 'messages/message', locals: { message: message })
  end
end
