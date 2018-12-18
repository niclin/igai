class Product < ApplicationRecord
  is_impressionable

  has_many :product_attachments, dependent: :destroy

  accepts_nested_attributes_for :product_attachments

  belongs_to :user

  has_many :chat_rooms

  def owner?(user)
    self.user == user
  end
end
