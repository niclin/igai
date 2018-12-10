class ProductsController < ApplicationController
  impressionist actions: [:show]

  def index
    @products = Product.all
  end

  def show
    @product = Product.find(params[:id])
  end

  def find_or_create_chat_room
    @product = Product.find(params[:id])
    redirect_back(fallback_location: root_path) && return if @product.user == current_user

    @chat_room = current_user.chat_rooms.find_or_create_by(product: @product, user: current_user)
    redirect_to chat_room_messages_path(@product, @chat_room)
  end
end
