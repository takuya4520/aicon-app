class LikeIconsController < ApplicationController
  def index
    # N+1問題対策
    post_icon_like_icons = current_user.post_icon_like_icons.includes(:user)
    # N+1問題対策
    created_icon_like_icons = current_user.created_icon_like_icons.includes(:user)
    # post_icon+created_icon
    like_icons = (post_icon_like_icons + created_icon_like_icons).sort_by(&:created_at).reverse
    @like_icons = Kaminari.paginate_array(like_icons).page(params[:page]).per(10)
  end
end