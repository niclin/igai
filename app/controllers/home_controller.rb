class HomeController < ApplicationController
  layout "home"

  def index
    set_meta_tags title: "機車二手精品交流買賣網",
                  description: "94愛改，交流買賣精品不再麻煩",
                  og: {
                    image: ActionController::Base.helpers.asset_path('showcase-3.jpg')
                  }
  end
end
