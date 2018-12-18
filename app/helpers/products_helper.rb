module ProductsHelper
  def render_product_description(product)
    truncate(strip_tags(product.description), length: 50)
  end
end
