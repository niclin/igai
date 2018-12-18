class Account::ProductsController < Account::BaseController
  def index
    @products = current_user.products.all
  end

  def new
    @product = current_user.products.new
    @product.attachments.build
  end

  def create
    @product = current_user.products.new(product_params)

    if @product.save
      params[:product_attachments]['image'].each do |image|
        @product_attachment = @product.attachments.create!(image: image, product_id: @product.id)
      end

      redirect_to account_products_path, notice: 'Product was successfully created.'
    else
      render :new
    end
  end

  def edit
    @product = current_user.products.find(params[:id])
    @product_attachments = @product.attachments
  end

  def update
    @product = current_user.products.find(params[:id])

    redirect_to account_products_path, notice: 'Product was successfully updated.'

    if @product.update(product_params)
    else
      render :edit
    end
  end

  def destroy_picture
    @product = Product.find(params[:id])

    @product.pictures.find(params[:picture_id]).purge

    render json: { status: :ok }
  end

  private

  def product_params
    params.require(:product).permit(:title, :description, :price, attachments_attributes: [:id, :image, :_destroy])
  end
end
