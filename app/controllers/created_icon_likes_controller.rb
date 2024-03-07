class CreatedIconLikesController < ApplicationController
  def create
    @created_icon = CreatedIcon.find(params[:icon_id])
    current_user.created_icon_like(@created_icon)
  end

  def destroy
    @created_icon= current_user.created_icon_likes.find(params[:id]).created_icon
    current_user.created_icon_unlike(@created_icon)
  end
end
