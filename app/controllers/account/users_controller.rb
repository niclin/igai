class Account::UsersController < Account::BaseController
  def edit
    @user = current_user
  end

  def update
    @user = current_user

    if @user.update(user_params)
      redirect_to user_path(@user), notice: "修改成功!"
    else
      render :edit
    end
  end

  private

  def user_params
    params.require(:user).permit(:name, :avatar, :phone, :facebook_url, :line_url, :shopee_url)
  end
end
