class MessagesController < ApplicationController
  def create
    @chat_room = ChatRoom.find(params[:id])

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
end
