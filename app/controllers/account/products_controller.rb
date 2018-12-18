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
      redirect_to account_products_path, notice: 'Product was successfully created.'
    else
      render :new
    end
  end

  def edit
    @product = current_user.products.find(params[:id])
    @product.attachments.build if @product.attachments.empty?
  end

  def update
    @product = current_user.products.find(params[:id])

    redirect_to account_products_path, notice: 'Product was successfully updated.'

    if @product.update(product_params)
    else
      render :edit
    end
  end

  private

  def product_params
    params.require(:product).permit(:title, :description, :price, attachments_attributes: [:id, :image, :_destroy])
  end
end
