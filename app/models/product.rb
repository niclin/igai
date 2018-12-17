class Product < ApplicationRecord
  is_impressionable
  has_many_attached :pictures

  belongs_to :user

  has_many :chat_rooms

  def owner?(user)
    self.user == user
  end
end
