module UsersHelper
  def render_user_line_button(user)
    if user.line_url.present?
      link_to(user.line_url) do
        image_tag("https://scdn.line-apps.com/n/line_add_friends/btn/zh-Hant.png", alt: "加入好友", height: 36, border: 0)
      end
    end
  end
end
