class Admin::PostIconsController < Admin::BaseController
  before_action :set_post_icon, only: %i[edit update destroy]
  def index
    #N+1問題対策
    @post_icons = PostIcon.includes(:user).order("created_at DESC").page(params[:page]).per(10)
  end

  def edit; end

  def update
    if @post_icon.update(post_icon_params)
      flash[:success] = "投稿アイコンを更新しました。"
      redirect_to admin_post_icons_path
    else
      flash.now['error'] = "投稿アイコンの編集に失敗しました。"
      render :edit
    end
  end

  def destroy
    @post_icon.destroy!
    flash[:error] = "投稿アイコンを削除しました。"
    redirect_to admin_post_icons_path, status: :see_other
  end

  private

  def set_post_icon
    @post_icon = PostIcon.find(params[:id])
  end

  def post_icon_params
    params.require(:post_icon).permit(:title, :icon, :status)
  end
end