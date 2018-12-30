module UsersHelper
  def render_user_avatar(user)
    if user.avatar.present?
      image_tag(user.avatar.medium.url, class: "rounded-circle")
    end
  end

  def render_user_line_button(user)
    if user.line_url.present?
      link_to(user.line_url) do
        image_tag("https://scdn.line-apps.com/n/line_add_friends/btn/zh-Hant.png", alt: "加入好友", height: 39)
      end
    end
  end

  def render_user_facebook_button(user)
    if user.facebook_url.present?
      link_to(user.facebook_url, class: "btn btn-facebook") do
        tag.i class: "fa fa-facebook"
      end
    end
  end

  def render_user_shopee_button(user)
    if user.shopee_url.present?
      link_to(user.shopee_url, class: "btn btn-odnoklassniki") do
        "蝦皮"
      end
    end
  end
end
