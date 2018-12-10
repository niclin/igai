class MessagesController < ApplicationController
  before_action :find_chat_room, only: [:create]

  def create

    @message = @chat_room.messages.new(message_params)
    @message.user = current_user

    if @message.save
      redirect_back(fallback_location: root_path)
    end
  end

  private

  def message_params
    params.require(:message).permit(:context)
  end

  def find_chat_room
    @chat_room = ChatRoom.find(params[:id])
  end
end
