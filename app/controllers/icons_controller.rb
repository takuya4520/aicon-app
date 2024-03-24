class IconsController < ApplicationController
  skip_before_action :require_login, only: %i[index]

  def index
    if params[:search].present? && params[:taste].present?
      created_icons = CreatedIcon.where("title LIKE ? AND taste = ?", "%#{params[:search]}%", params[:taste]).where(status: :published).includes(:user)
      icons = created_icons.sort_by(&:created_at).reverse
    

    elsif params[:taste].present?
      created_icons = CreatedIcon.where("taste = ?", params[:taste]).where(status: :published).includes(:user)
      icons = created_icons.sort_by(&:created_at).reverse

    elsif params[:search].present?
      post_icons = PostIcon.where("title LIKE ?", "%#{params[:search]}%").where(status: :published).includes(:user)
      created_icons = CreatedIcon.where("title LIKE ?", "%#{params[:search]}%").where(status: :published).includes(:user)
      icons = (post_icons + created_icons).sort_by(&:created_at).reverse

    else
      # 検索キーワードが存在しない場合、すべてのアイコンを取得
      post_icons = PostIcon.where(status: :published).includes(:user)
      created_icons = CreatedIcon.where(status: :published).includes(:user)
      icons = (post_icons + created_icons).sort_by(&:created_at).reverse
    end

    @icons = Kaminari.paginate_array(icons).page(params[:page]).per(10)
  end
end