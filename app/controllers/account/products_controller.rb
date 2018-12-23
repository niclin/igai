class Account::ProductsController < Account::BaseController
  def index
    @products = current_user.products.all.paginate(page: params[:page], per_page: 10)
  end

  def new
    @product = current_user.products.new
  end

  def create
    @product = current_user.products.new(product_params)

    respond_to do |format|
      if @product.save

        format.html { redirect_to account_products_path, notice: 'Product was successfully created.' }
        format.json { render json: { redirectURL: account_products_url }.to_json, status: :created }
      else
        format.html { render :new }
        format.json { render json: @product.errors, status: :unprocessable_entity }
      end
    end
  end

  def edit
    @product = current_user.products.find(params[:id])
  end

  def update
    @product = current_user.products.find(params[:id])

    respond_to do |format|
      if @product.update(product_params)
        format.html { redirect_to account_products_path, notice: "#{@product.title} 更新成功！" }
        format.json { render json: { redirectURL: account_products_url }.to_json, status: :ok }
      else
        format.html { render :edit }
        format.json { render json: @product.errors, status: :unprocessable_entity }
      end
    end
  end

  private

  def product_params
    params.require(:product).permit(:title, :description, :price, attachments_attributes: [:id, :image, :_destroy])
  end
end
