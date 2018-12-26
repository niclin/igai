module ProductsHelper
  def render_product_description(product)
    truncate(product.description, length: 30)
  end

  def render_product_title(product)
    truncate(product.title, length: 20)
  end

  def render_product_price(product)
    "價格：#{product.price} 元"
  end

  def render_product_type_badge(product)
    case product.product_type
    when "sell"
      tag.span class: "badge badge-success" do
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

  def render_cached_grouped_catrgory_collection
    Rails.cache.fetch("grouped-category-collection", expires_in: 1.day) do
      CategoryGroup.all.includes(:categories).map { |cg| [cg.name, cg.categories.pluck(:name, :id)] }
    end
  end
end
