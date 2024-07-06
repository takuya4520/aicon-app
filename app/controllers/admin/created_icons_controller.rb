class Admin::CreatedIconsController < Admin::BaseController
  before_action :set_created_icon, only: %i[edit update destroy]
  def index
    # N+1問題対策
    @created_icons = CreatedIcon.includes(:user).order("created_at DESC").page(params[:page]).per(10)
  end

  def edit; end

  def update
    if @created_icon.update(created_icon_params)
      flash[:success] = "投稿アイコンを更新しました。"
      redirect_to admin_created_icons_path
    else
      flash.now['error'] = "投稿アイコンの編集に失敗しました。"
      render :edit
    end
  end

  def destroy
    @created_icon.destroy!
    flash[:error] = "投稿アイコンを削除しました。"
    redirect_to admin_created_icons_path, status: :see_other
  end

  private

  def set_created_icon
    @created_icon = CreatedIcon.find(params[:id])
  end

  def created_icon_params
    params.require(:created_icon).permit(:title, :icon, :status)
  end
end
