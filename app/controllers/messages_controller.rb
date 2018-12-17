class MessagesController < ApplicationController
  before_action :find_chat_room, only: [:create, :read]

  def create

    @message = @chat_room.messages.new(message_params)
    @message.user = current_user

    if @message.save
      redirect_back(fallback_location: root_path)
    end
  end

  def read
    # FIX: 不該用 params[:user_id], 想看看有沒有別的辦法拿 current_user
    @messages = @chat_room.messages.by_recipient(params[:user_id]).unread
    @messages.update_all(read_at: Time.zone.now)

    respond_to do |format|
      format.json { head 201 }
    end

    ActionCable.server.broadcast "chat_rooms_#{@chat_room.id}_channel", { event: "mark_as_read" }
  end

  private

  def message_params
    params.require(:message).permit(:context)
  end

  def find_chat_room
    @chat_room = ChatRoom.find(params[:id])
  end
end
