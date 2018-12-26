class Account::ProductsController < Account::BaseController
  def index
    @products = current_user.products.includes(:attachments, :categories).all.paginate(page: params[:page], per_page: 10)

    set_meta_tags title: "我的商品列表"
  end

  def new
    @product = current_user.products.new

    set_meta_tags title: "新增商品"
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

    set_meta_tags title: "編輯 #{@product.title} 商品"
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

  def update_states
    @product = current_user.products.find(params[:id])

    status = params[:status]

    success =
     case status
     when "online"
       @product.go_live!
     when "offline"
       @product.go_offline!
     when "sold"
       @product.sold_out!
     else
       false
     end

    if success
      redirect_to account_products_path, notice: "#{@product.title} 更新成功。"
    else
      redirect_back(fallback_location: root_path, alert: "#{@product.title} 更新狀態失敗")
    end
  end

  private

  def product_params
    params.require(:product).permit(:title, :product_type, :description, :price, category_ids: [], attachments_attributes: [:id, :image, :_destroy])
  end
end
