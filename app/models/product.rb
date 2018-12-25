class Product < ApplicationRecord
  TYPE = %w(sell buy exchange).freeze
  ATTACHMENT_LIMIT = 5

  is_impressionable counter_cache: true, unique: true

  validates :title, presence: true
  validates :description, presence: true
  validates :price, presence: true
  validates :product_type, presence: true, inclusion: { in: TYPE }
  validates :attachments, length: { minimum: 1, message: "請至少上傳一張照片" }
  validates :categories, length: { maximum: 5, message: "最多只可以選擇 5 種車系" }

  has_many :attachments, class_name: "ProductAttachment", dependent: :destroy
  has_many :chat_rooms
  has_many :categorizations
  has_many :categories, through: :categorizations

  belongs_to :user

  accepts_nested_attributes_for :attachments, allow_destroy: true, reject_if: :all_blank

  def owner?(user)
    self.user == user
  end

  def remainder_attachment_quota
    return ATTACHMENT_LIMIT if new_record?

    ATTACHMENT_LIMIT - attachments.count
  end
end
