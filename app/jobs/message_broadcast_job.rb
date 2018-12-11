class MessageBroadcastJob < ApplicationJob
  queue_as :default

  def perform(message)
    ActionCable.server.broadcast "chat_rooms_#{message.chat_room.id}_channel", message: render_message(message)
    ActionCable.server.broadcast "notifications_#{message.chat_room.product.user.id}_channel", message: "New Message"
  end

  private

  def render_message(message)
    MessagesController.render partial: 'messages/message', locals: {message: message}
  end
end
