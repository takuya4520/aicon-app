class UserSessionsController < ApplicationController
  skip_before_action :require_login, only: %i[create new guest_login]
  def new; end

  def create
    @user = login(params[:email], params[:password])
    if @user
      flash[:success] = "ログインしました"
      redirect_back_or_to new_created_icon_path
    else
      flash.now[:error] = 'ログインに失敗しました'
      render :new, status: :unprocessable_entity
    end
  end

  def destroy
    logout
    flash[:success] = "ログアウトしました"
    redirect_to root_path
  end

  def guest_login
    @guest_user = User.create(
      name: 'ゲスト',
      email: SecureRandom.alphanumeric(10) + "@email.com",
      password: 'password',
      password_confirmation: 'password'
    )
    auto_login(@guest_user)
    flash[:success] = "ゲストとしてログインしました。再度ログインできないので注意してください。"
    redirect_to new_created_icon_path
  end
end
