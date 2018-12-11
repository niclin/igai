class ApplicationController < ActionController::Base
  before_action :cookie_set

  def cookie_set
    @user = current_user
    return unless current_user
    cookies[:user_id] = { value: @user.id, domain: :all }
  end
end
