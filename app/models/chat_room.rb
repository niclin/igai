class ChatRoom < ApplicationRecord
  belongs_to :product
  belongs_to :user

  has_many :messages

  def access?(user)
    [product.user, self.user].include?(user)
  end
end
