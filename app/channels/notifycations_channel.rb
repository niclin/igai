class NotifycationsChannel < ApplicationCable::Channel
  def subscribed
    if params[:user_id]
      stream_from "notifications_#{params[:user_id]}_channel"
    end
  end

  def unsubscribed
    # Any cleanup needed when channel is unsubscribed
  end
end
