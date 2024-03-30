class IconsController < ApplicationController
  skip_before_action :require_login, only: %i[index]

  def index
    if params[:search].present?
      # 検索キーワードが存在する場合、検索条件にマッチするアイコンを検索
      post_icons = PostIcon.where("title LIKE ?", "%#{params[:search]}%").where(status: :published).includes(:user)
      created_icons = CreatedIcon.where("title LIKE ?", "%#{params[:search]}%").where(status: :published).includes(:user)
    else
      # 検索キーワードが存在しない場合、すべてのアイコンを取得
      post_icons = PostIcon.where(status: :published).includes(:user)
      created_icons = CreatedIcon.where(status: :published).includes(:user)
    end

    icons = (post_icons + created_icons).sort_by(&:created_at).reverse
    @icons = Kaminari.paginate_array(icons).page(params[:page]).per(10)
  end
end