class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_many :products
  has_many :sender_chat_rooms, class_name: "ChatRoom", foreign_key: "sender_id"
  has_many :receiver_chat_rooms, class_name: "ChatRoom,", foreign_key: "receiver_id"
  has_many :messages

  def chat_rooms
    ChatRoom.where("sender_id = ? OR receiver_id = ?", self.id, self.id)
  end

  def has_unread_messages?
    unread_messages_count > 0
  end

  def unread_messages_count
    Rails.cache.fetch("#{self.id}-unread-messages-count", expires_in: 1.minute) do
      Message.where(chat_room_id: chat_rooms.ids).by_recipient(self.id).unread.count
    end
  end
end
