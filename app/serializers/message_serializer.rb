class MessageSerializer < ActiveModel::Serializer
  attributes :id, :context, :created_at, :read_at, :read
  belongs_to :user

  def read
    object.read?
  end
end
