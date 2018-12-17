class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_many :products
  has_many :sender_chat_rooms, class_name: "ChatRoom", foreign_key: "sender_id"
  has_many :receiver_chat_rooms, class_name: "ChatRoom,", foreign_key: "receiver_id"
  has_many :messages
end
