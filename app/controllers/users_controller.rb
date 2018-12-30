class UsersController < ApplicationController

  def show
    @user = User.friendly.find(params[:id])

    products = @user.products

    @buy_products = products.where(product_type: "buy")
    @sell_products = products.where(product_type: "sell")
    @exchange_products = products.where(product_type: "exchange")

    set_meta_tags title: "#{user.name} 的個人主頁"
  end
end
