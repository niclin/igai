class ChatRoom < ApplicationRecord
  belongs_to :product
  belongs_to :sender , class_name: "User"
  belongs_to :receiver, class_name: "User"

  has_many :messages, dependent: :destroy

  def access?(user)
    [sender, receiver].include?(user)
  end

  def recipients(user)
    return sender if user == receiver
    return receiver if user == sender
  end
end
