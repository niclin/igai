class MessageSerializer < ActiveModel::Serializer
  attributes :id, :context, :created_at
  belongs_to :user
end
