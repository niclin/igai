class UsersController < ApplicationController

  def show
    @user = User.friendly.find(params[:id])

    products = @user.products

    @buy_products = products.where(product_type: "buy")
    @sell_products = products.where(product_type: "sell")
    @exchange_products = products.where(product_type: "exchange")
  end
end
