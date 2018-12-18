class Account::ProductsController < Account::BaseController
  def index
    @products = current_user.products.all
  end

  def new
    @product = current_user.products.new
    @product_attachment = @product.product_attachments.build
  end

  def create
    @product = current_user.products.new(product_params)

    if @product.save
      params[:product_attachments]['image'].each do |image|
        @product_attachment = @product.product_attachments.create!(image: image, product_id: @product.id)
      end

      redirect_to account_products_path, notice: 'Product was successfully created.'
    else
      render :new
    end
  end

  def edit
    @product = current_user.products.find(params[:id])
    @product_attachments = @product.product_attachments
  end

  def update
    @product = current_user.products.find(params[:id])


  end

  def destroy_picture
    @product = Product.find(params[:id])

    @product.pictures.find(params[:picture_id]).purge

    render json: { status: :ok }
  end

  private

  def product_params
    params.require(:product).permit(:title, :description, :price, product_attachments_attributes: [:id, :product_id, :image])
  end
end
