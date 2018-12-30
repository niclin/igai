class PagesController < ApplicationController
  def about
    set_meta_tags title: "關於本站"
  end

  def privacy
    set_meta_tags title: "隱私權政策"
  end
end
