module ProductsHelper
  def render_product_description(product)
    truncate(product.description, length: 30)
  end

  def render_product_price(product)
    "價格：#{product.price} 元"
  end
end
