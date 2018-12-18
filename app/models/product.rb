class Product < ApplicationRecord
  is_impressionable

  has_many :attachments, class_name: "ProductAttachment", dependent: :destroy

  accepts_nested_attributes_for :attachments, allow_destroy: true, reject_if: :all_blank

  belongs_to :user

  has_many :chat_rooms

  def owner?(user)
    self.user == user
  end
end
