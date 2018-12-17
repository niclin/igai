class ChatRoom < ApplicationRecord
  belongs_to :product
  belongs_to :sender , class_name: "User"
  belongs_to :receiver, class_name: "User"

  has_many :messages

  def access?(user)
    [sender, receiver].include?(user)
  end
end
