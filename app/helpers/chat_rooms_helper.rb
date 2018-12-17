module ChatRoomsHelper
  def render_messages_unread_count_by_chat_room(chat_room, user)
    chat_room.messages.by_recipient(current_user.id).unread.count
  end
end
