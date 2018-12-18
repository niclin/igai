module ProductsHelper
  def render_product_description(product)
    truncate(strip_tags(product.description), length: 50)
  end

  def render_product_price(product)
    "價格：#{product.price} NT"
  end
end
