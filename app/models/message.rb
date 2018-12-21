class Message < ApplicationRecord
  belongs_to :user
  belongs_to :chat_room

  scope :by_recipient, ->(user_id) { where.not(user_id: user_id) }
  scope :unread, -> { where(read_at: nil) }
  scope :asc, -> { order(id: :asc) }

  validates :context, presence: true

  after_create_commit { MessageBroadcastJob.perform_later(self) }

  def read?
    read_at.present?
  end
end
