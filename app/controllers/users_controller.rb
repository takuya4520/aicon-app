class UsersController < ApplicationController
  skip_before_action :require_login, only: %i[create new]
  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    @user.current_icon.attach(params[:user][:current_icon])
    if @user.save
      login(user_params[:email], user_params[:password])
      flash[:success] = "ログインしました"
      redirect_to new_created_icon_path
    else
      flash.now[:error] = '新規登録に失敗しました'
      render :new
    end
  end
  
  private

    def user_params
      params.require(:user).permit(:email, :password, :password_confirmation, :name, :salt, :current_icon)
    end
end
