class UsersController < ApplicationController
  skip_before_action :require_login, only: %i[create new]
  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    if @user.save
      redirect_to login_path
    else#
      render :new
    end
  end

  def show
    @user = User.find(params[:id])
    post_icons = @user.post_icons.includes(:user)
    created_icons = @user.created_icons.includes(:user)
    @icons = (post_icons + created_icons).sort_by(&:created_at).reverse
  end

  private

  def user_params
        params.require(:user).permit(:email, :password, :password_confirmation, :name, :salt)
   end
end
