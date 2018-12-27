class UserMailer < ApplicationMailer

  def notify_unread_messages(user_id)
    @user = User.find(user_id)

    mail(to: @user.email , subject: "Hello, #{@user.name} 您在 iGai愛改 有未讀的訊息喔！")
  end
end
