class IconsController < ApplicationController
  skip_before_action :require_login, only: %i[index]
  def index
    post_icons = PostIcon.where(status: :published).includes(:user)
    created_icons = CreatedIcon.where(status: :published).includes(:user)
    @icons = (post_icons + created_icons).sort_by(&:created_at).reverse
  end
end
