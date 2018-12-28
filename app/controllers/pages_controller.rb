class PagesController < ApplicationController
  def about
    set_meta_tags title: "關於本站"
  end
end
