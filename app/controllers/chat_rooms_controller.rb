class ChatRoomsController < ApplicationController
  before_action :find_chat_room, only: [:messages]
  before_action :require_sender_or_recevier!

  def messages
    @product = Product.find(params[:id])
    @messages = @chat_room.messages

    respond_to do |format|
      format.html
      format.json { render json: @messages, each_serializer: MessageSerializer }
    end
  end

  def require_sender_or_recevier!
    redirect_back(fallback_location: root_path, notice: "沒有權限進入聊天室") if !@chat_room.access?(current_user)
  end

  private

  def find_chat_room
    @chat_room = ChatRoom.find(params[:chat_room_id])
  end
end
