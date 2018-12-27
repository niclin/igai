class NotifyUnreadMessages
  include Sidekiq::Worker
  sidekiq_options unique: :until_executed
  sidekiq_options retry: false

  def perform
    User.find_each do |user|
      UserMailer.notify_unread_messages(user.id).deliver_later if user.has_unread_messages?
    end
  end
end
