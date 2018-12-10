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

  private

  def product_params
    params.require(:product).permit(:title, :description, :price, pictures: [])
  end
end
