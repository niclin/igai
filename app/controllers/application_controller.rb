class ApplicationController < ActionController::Base
  before_action :cookie_set, :set_gon

  private

  def cookie_set
    @user = current_user
    return unless current_user
    cookies[:user_id] = @user.id
    gon.user_id = current_user.id
  end

  def set_gon
    gon.general = {
      rails: {
        csrf: {
          token: form_authenticity_token
        }
      }
    }
  end
end
