class Product < ApplicationRecord
  ATTACHMENT_LIMIT = 5
  is_impressionable counter_cache: true, unique: true

  validates :title, presence: true
  validates :description, presence: true
  validates :price, presence: true
  validates :attachments, length: { minimum: 1, message: "請至少上傳一張照片" }

  has_many :attachments, class_name: "ProductAttachment", dependent: :destroy
  has_many :chat_rooms

  belongs_to :user

  accepts_nested_attributes_for :attachments, allow_destroy: true, reject_if: :all_blank

  before_destroy :check_attachment_presence

  def owner?(user)
    self.user == user
  end

  def remainder_attachment_quota
    return ATTACHMENT_LIMIT if new_record?

    ATTACHMENT_LIMIT - attachments.count
  end
end
