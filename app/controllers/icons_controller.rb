class IconsController < ApplicationController
  skip_before_action :require_login, only: %i[index]

  def index
    # 検索キーワード＋テイストの絞り込み
    if params[:search].present? && params[:taste].present?
      # N+1問題対策
      created_icons = CreatedIcon.where("title LIKE ? AND taste = ?", "%#{params[:search]}%", params[:taste]).where(status: :published).includes(:user)
      icons = created_icons.sort_by(&:created_at).reverse
    
    # テイストの絞り込み
    elsif params[:taste].present?
      # N+1問題対策
      created_icons = CreatedIcon.where(taste: params[:taste]).where(status: :published).includes(:user)
      icons = created_icons.sort_by(&:created_at).reverse

    # 検索キーワードの絞り込み
    elsif params[:search].present?
      # N+1問題対策
      post_icons = PostIcon.where("title LIKE ?", "%#{params[:search]}%").where(status: :published).includes(:user)
      created_icons = CreatedIcon.where("title LIKE ?", "%#{params[:search]}%").where(status: :published).includes(:user)
      icons = (post_icons + created_icons).sort_by(&:created_at).reverse

    # 検索キーワードとテイストの絞り込みが存在しない場合
    else
      # N+1問題対策
      post_icons = PostIcon.where(status: :published).includes(:user)
      created_icons = CreatedIcon.where(status: :published).includes(:user)
      icons = (post_icons + created_icons).sort_by(&:created_at).reverse
    end

    @icons = Kaminari.paginate_array(icons).page(params[:page]).per(10)
  end
end