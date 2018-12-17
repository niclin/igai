class ChatRoomsController < ApplicationController
  before_action :find_chat_room, only: [:messages]
  before_action :require_sender_or_recevier!, only: [:messages]

  def index
    @chat_rooms = current_user.chat_rooms
  end

  def messages
    @messages = @chat_room.messages.includes(:user).asc
    @product = @chat_room.product

    respond_to do |format|
      format.html
      format.json { render json: @messages, each_serializer: MessageSerializer }
    end
  end

  private

  def require_sender_or_recevier!
    redirect_back(fallback_location: root_path, notice: "沒有權限進入聊天室") if !@chat_room.access?(current_user)
  end

  def find_chat_room
    @chat_room = ChatRoom.find(params[:id])
  end
end
