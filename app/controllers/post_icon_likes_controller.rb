class PostIconLikesController < ApplicationController
  def create
    @post_icon = PostIcon.find(params[:icon_id])
    current_user.post_icon_like(@post_icon)
  end

  def destroy
    @post_icon= current_user.post_icon_likes.find(params[:id]).post_icon
    current_user.post_icon_unlike(@post_icon)
  end
end
