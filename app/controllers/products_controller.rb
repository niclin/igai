class ProductsController < ApplicationController
  before_action :find_product, only: [:show, :find_or_create_chat_room]
  before_action :authenticate_user!, only: [:find_or_create_chat_room]

  impressionist actions: [:show]

  def index
    @products = Product.all.paginate(page: params[:page], per_page: 12).includes(:attachments)

    set_meta_tags title: "商品一覽"
  end

  def show
    @product = Product.find(params[:id])

    set_meta_tags title: @product.title,
                  description: @product.description,
                  og: {
                    title: @product.title,
                    image: @product.attachments.map { |attachment| attachment.image.medium.url }
                  }
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
