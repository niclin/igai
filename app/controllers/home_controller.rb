class HomeController < ApplicationController
  layout "home"

  def index
    set_meta_tags title: "最好用的機車二手精品交流買賣網"
  end
end
