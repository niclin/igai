class ProductsController < ApplicationController
  before_action :find_product, only: [:show, :find_or_create_chat_room]
  before_action :authenticate_user!, only: [:find_or_create_chat_room]
  before_action :require_online!, only: [:show, :find_or_create_chat_room]

  impressionist actions: [:show]

  def index
    @products = Product.online.published.recent.paginate(page: params[:page], per_page: 12).includes(:attachments, :categories)

    set_meta_tags title: "商品一覽"
  end

  def show
    @product = Product.find(params[:id])

    set_meta_tags title: combine_type_and_title(@product),
                  description: @product.description,
                  og: {
                    title: combine_type_and_title(@product),
                    image: og_image(@product)
                  }
  end

  def find_or_create_chat_room
    redirect_back(fallback_location: root_path) && return if @product.owner?(current_user)

    @chat_room = current_user.sender_chat_rooms.find_or_create_by(product: @product, receiver: @product.user)
    redirect_to messages_chat_room_path(@chat_room)
  end

  private

  def find_product
    @product = Product.find(params[:id])
  end

  def combine_type_and_title(product)
    "#{I18n.t("general.product_type.#{product.product_type}")} #{product.title}"
  end

  def require_online!
    return if @product.owner?(current_user)
    redirect_back(fallback_location: products_path, alert: "該商品已下架") if !@product.online?
  end

  def og_image(product)
    return @product.attachments.new.image.url if @product.product_type == "buy"
    @product.attachments.map { |attachment| attachment.image.medium.url }
  end
end
