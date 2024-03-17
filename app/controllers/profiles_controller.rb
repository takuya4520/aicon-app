class ProfilesController < ApplicationController
  before_action :set_user, only: %i[show edit update]

  def edit; end

  def update
    if @user.update(user_params)
      flash[:success] = "ユーザー情報を編集しました"
      redirect_to profile_path
    else
      flash.now[:danger] = "編集に失敗しました"
      render :edit
    end
  end

  def show
    post_icons = @user.post_icons.includes(:user)
    created_icons = @user.created_icons.includes(:user)
    @icons_all = (post_icons + created_icons).sort_by(&:created_at).reverse
    @icons = Kaminari.paginate_array(@icons_all).page(params[:page]).per(10)
  end

  private

  def set_user
    @user = User.find(current_user.id)
  end

  def user_params
    params.require(:user).permit(:email, :password, :password_confirmation, :name, :salt, :current_icon)
  end
end