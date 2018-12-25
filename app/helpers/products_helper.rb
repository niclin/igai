module ProductsHelper
  def render_product_description(product)
    truncate(product.description, length: 30)
  end

  def render_product_price(product)
    "價格：#{product.price} 元"
  end

  def render_product_type_badge(product)
    case product.product_type
    when "sell"
      tag.span class: "badge badge-primary" do
        "出售"
      end
    when "buy"
      tag.span class: "badge badge-warning" do
        "收購"
      end
    when "exchange"
      tag.span class: "badge badge-info" do
        "交流"
      end
    end
  end
end
