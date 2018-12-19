class Product < ApplicationRecord
  is_impressionable counter_cache: true, unique: true

  has_many :attachments, class_name: "ProductAttachment", dependent: :destroy
  has_many :chat_rooms

  belongs_to :user

  accepts_nested_attributes_for :attachments, allow_destroy: true, reject_if: :all_blank

  def owner?(user)
    self.user == user
  end
end
