class CreatedIconLikesController < ApplicationController
  before_action :set_created_icon

  def create
    @created_icon_like = CreatedIconLike.new(user_id: current_user.id,  created_icon_id: @created_icon.id)
    @created_icon_like.save
    redirect_to icons_path
  end

  def destroy
    @created_icon_like = current_user.created_icon_likes.find(params[:id])
    @created_icon_like.destroy
    redirect_to icons_path, status: :see_other
  end

  private

  def set_created_icon
    @created_icon = CreatedIcon.find_by(id: params[:icon_id])
  end
end
