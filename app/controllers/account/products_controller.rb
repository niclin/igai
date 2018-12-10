class Account::ProductsController < Account::BaseController
  def index
    @products = current_user.products.all
  end

  def new
    @product = current_user.products.new
  end

  def create
    @product = current_user.products.new(product_params)

    if @product.save
      redirect_to account_products_path
    else
      render :new
    end
  end

  def edit
    @product = current_user.products.find(params[:id])
  end

  def update
    @product = current_user.products.find(params[:id])

    if @product.update(product_params)
      redirect_to account_products_path
    else
      render :edit
    end
  end

  def destroy_picture
    @product = Product.find(params[:id])

    @product.pictures.find(params[:picture_id]).purge

    respond_to do |format|
      format.html { redirect_back(fallback_location: account_products_path, notice: 'Product picture was successfully destroyed.') }
      format.json { head :no_content }
    end
  end

  private

  def product_params
    params.require(:product).permit(:title, :description, :price, pictures: [])
  end
end
