class ProductsController < ApplicationController
  before_action :find_product, only: [:show, :find_or_create_chat_room]
  before_action :authenticate_user!, only: [:find_or_create_chat_room]

  impressionist actions: [:show]

  def index
    @products = Product.all
  end

  def show
    @product = Product.find(params[:id])
  end

  def find_or_create_chat_room
    redirect_back(fallback_location: root_path) && return if @product.user == current_user

    @chat_room = current_user.sender_chat_rooms.find_or_create_by(product: @product, receiver: @product.user)
    redirect_to messages_chat_room_path(@chat_room)
  end

  private

  def find_product
    @product = Product.find(params[:id])
  end
end
