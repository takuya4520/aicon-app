class Admin::UsersController < Admin::BaseController
  before_action :set_user, only: %i[edit update destroy]
  def index
    @users = User.all.order("created_at DESC").page(params[:page]).per(10)
  end

  def edit; end

  def update
    if @user.update(user_params)
      flash[:success] = "Userを更新しました。"
      redirect_to admin_users_path(@user)
    else
      flash.now['error'] = "Userの編集に失敗しました。"
      render :edit
    end
  end

  def destroy
    @user.destroy!
    flash[:error] = "Userを削除しました。"
    redirect_to admin_users_path, status: :see_other
  end

  private

  def set_user
    @user = User.find(params[:id])
  end

  def user_params
    params.require(:user).permit(:name, :role, :email)
  end
end