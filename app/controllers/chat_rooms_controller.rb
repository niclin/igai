class ChatRoomsController < ApplicationController
  def messages
    @product = Product.find(params[:id])

    @chat_room = ChatRoom.find(params[:chat_room_id])

    @messages = @chat_room.messages
  end
end
