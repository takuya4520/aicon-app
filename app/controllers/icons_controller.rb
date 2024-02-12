class IconsController < ApplicationController
  skip_before_action :require_login, only: %i[index]
  def index
    post_icons = PostIcon.all.includes(:user)
    created_icons = CreatedIcon.all.includes(:user)
    @icons = (post_icons + created_icons).sort_by(&:created_at).reverse
  end
end
