class Account::ProductsController < Account::BaseController
  def index
    @products = Product.all
  end

  def new
    @product = Product.new
  end

  def create
    @product = Product.new(product_params)

    if @product.save
      redirect_to account_products_path
    else
      render :new
    end
  end

  def edit

  end

  def update

  end

  private

  def product_params
    params.require(:product).permit(:title, :description, :price, pictures: [])
  end
end
