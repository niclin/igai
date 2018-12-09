class ProductsController < ApplicationController
  impressionist actions: [:show]

  def index
    @products = Product.all
  end

  def show
    @product = Product.find(params[:id])
  end
end
