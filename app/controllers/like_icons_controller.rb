class LikeIconsController < ApplicationController
  def index
    post_icon_like_icons = current_user.post_icon_like_icons.includes(:user)
    created_icon_like_icons = current_user.created_icon_like_icons.includes(:user)
    like_icons = (post_icon_like_icons + created_icon_like_icons).sort_by(&:created_at).reverse
    @like_icons = Kaminari.paginate_array(like_icons).page(params[:page]).per(10)
  end
end