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
      redirect_to root_path
    else
      flash.now[:error] = '新規登録に失敗しました'
      render :new
    end
  end

  def show
    @user = User.find(params[:id])
    post_icons = @user.post_icons.includes(:user)
    created_icons = @user.created_icons.includes(:user)
    @icons_all = (post_icons + created_icons).sort_by(&:created_at).reverse
    @icons = Kaminari.paginate_array(@icons_all).page(params[:page]).per(10)
  end

  def edit
    @user = current_user
  end

  def update
    @user = current_user
    if @user.update(user_params)
      flash[:success] = "ユーザー情報を編集しました"
      redirect_to user_path(current_user)
    else
      flash.now[:danger] = "編集に失敗しました"
      render :edit
    end
  end

  private

    def user_params
      params.require(:user).permit(:email, :password, :password_confirmation, :name, :salt, :current_icon)
    end
end
