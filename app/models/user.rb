class User < ApplicationRecord
  mount_uploader :avatar, AvatarUploader

  USERNAME_PATTERN = /\A[A-Za-z0-9]+(?:[ _-][A-Za-z0-9]+)*\z/

  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable,
         :omniauthable, :omniauth_providers => [:facebook, :google_oauth2]

  validates :name, presence: true, length: { minimum: 5 }, if: :name_changed?, on: :update

  before_validation :create_user_name

  has_many :products
  has_many :sender_chat_rooms, class_name: "ChatRoom", foreign_key: "sender_id"
  has_many :receiver_chat_rooms, class_name: "ChatRoom,", foreign_key: "receiver_id"
  has_many :messages

  def chat_rooms
    ChatRoom.where("sender_id = ? OR receiver_id = ?", self.id, self.id)
  end

  def has_unread_messages?
    unread_messages_count > 0
  end

  def unread_messages_count
    Rails.cache.fetch("#{self.id}-unread-messages-count", expires_in: 1.minute) do
      Message.where(chat_room_id: chat_rooms.ids).by_recipient(self.id).unread.count
    end
  end

  def create_user_name
    return if self.name.present?

    email_user_name = self.email.split("@").first.tr(".", "_")

    self.name = valid_user_name?(email_user_name) ? email_user_name : random_user_name
  end

  def self.from_omniauth(auth, signed_in_resource = nil)
    identity = Identity.find_for_oauth(auth)

    user = signed_in_resource ? signed_in_resource : identity.user

    if user.nil?
      email = auth.info.email

      user = User.where(email: email).first if email

      if user.nil?
        user = User.new(name: auth.info.name.gsub(/\s+/, '_'),
                        email: auth.info.email,
                        avatar: auth.info.image,
                        password: Devise.friendly_token[0,20])
        user.save!
      end
    end

    if identity.user != user
      identity.user = user
      identity.save!
    end

    user
  end

  def delete_access_token(auth)
    @graph ||= Koala::Facebook::API.new(auth.credentials.token)
    @graph.delete_connections(auth.uid, "permissions")
  end

  private

  def random_user_name
    "u#{Time.zone.now.to_i}"
  end

  def valid_user_name?(user_name)
    USERNAME_PATTERN.match(user_name) && User.where("lower(name) = ?", user_name.downcase).blank?
  end
end
