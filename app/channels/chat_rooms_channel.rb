class ChatRoomsChannel < ApplicationCable::Channel
  def subscribed
    stream_from "chat_rooms_#{params['chat_room_id']}_channel"
  end

  def unsubscribed
    # Any cleanup needed when channel is unsubscribed
  end

  def send_message(data)
    user = User.find(data['user_id'])
    user.messages.create!(context: data['message'], chat_room_id: data['chat_room_id'])
  end
end
