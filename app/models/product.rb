class Product < ApplicationRecord
  include AASM

  TYPE = %w(sell buy exchange).freeze
  ATTACHMENT_LIMIT = 5

  is_impressionable counter_cache: true, unique: true

  validates :title, presence: true, length: { maximum: 70 }
  validates :description, presence: true, length: { maximum: 500 }
  validates :price, presence: true, if: -> { product_type != "exchange" }
  validates :product_type, presence: true, inclusion: { in: TYPE }
  validates :attachments, length: { minimum: 1, message: "請至少上傳一張照片" }, if: -> { product_type != "buy" }
  validates :categories, length: { minimum: 1, maximum: 5, message: "請選擇至少 1 種以上 5 種 以下的車系" }

  has_many :attachments, class_name: "ProductAttachment", dependent: :destroy
  has_many :chat_rooms
  has_many :categorizations
  has_many :categories, through: :categorizations

  belongs_to :user

  accepts_nested_attributes_for :attachments, allow_destroy: true, reject_if: :all_blank

  scope :published, -> { where(is_hidden: false) }
  scope :hidden, -> { where(is_hidden: true) }
  scope :recent, -> { order(id: :desc) }

  aasm do
    state :online, initial: true
    state :offline, :sold

    event :go_live do
      transitions from: [:offline, :sold], to: :online
    end

    event :go_offline do
      transitions from: :online, to: :offline
    end

    event :sold_out do
      transitions from: [:online, :offline], to: :sold
    end
  end

  def owner?(user)
    self.user == user
  end

  def vip?
    user.admin?
  end

  def remainder_attachment_quota
    return ATTACHMENT_LIMIT if new_record?

    ATTACHMENT_LIMIT - attachments.count
  end
end
