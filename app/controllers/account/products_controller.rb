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

    respond_to do |format|
      if @product.update(product_params)
        format.html { redirect_to account_products_path }
        format.json {
          # 遵循慣例參數為陣列，但 DirectUpload 一次只會負責一張圖片
          image = ActiveStorage::Blob.find_signed(product_params[:pictures].first)
          # 從後端取的圖片（resize）的網址
          image_url = Rails.application.routes.url_helpers.rails_representation_url(image.variant(resize: '100x100'), only_path: true)

          render json: { status: :ok, url: image_url, id: image.id }
          }
      else
        format.html { render :edit }
        format.json { render json: @product.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy_picture
    @product = Product.find(params[:id])

    @product.pictures.find(params[:picture_id]).purge

    render json: { status: :ok }
  end

  private

  def product_params
    params.require(:product).permit(:title, :description, :price, pictures: [])
  end
end
