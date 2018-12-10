class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_many :products

  def chat_rooms
    ChatRoom.where("sender_id = ? OR receiver_id = ?", self.id, self.id)
  end
end
