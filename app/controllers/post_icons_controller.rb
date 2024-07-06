class PostIconsController < ApplicationController
  before_action :set_posticon, only: %i[edit update destroy]

  def show
    @posticon= PostIcon.find(params[:id])
  end

  def new
    @posticon = PostIcon.new
  end

  def edit; end

  def create
    @posticon = current_user.post_icons.build(posticon_params)
    @posticon.icon.attach(params[:post_icon][:icon])
    result = Vision.image_analysis(params[:post_icon][:icon])
    if result
      if @posticon.save
        flash[:success] = "アイコンを投稿しました"
        redirect_to post_icon_url(@posticon)
      else
        flash.now[:error] = "アイコンの投稿に失敗しました"
        render :new, status: :unprocessable_entity
      end
    else
      flash.now[:error] = "不適切の画像です"
      render :new, status: :unprocessable_entity
    end
  end

  def update
    if @posticon.update(posticon_params)
      flash[:success] = "投稿を編集しました"
      redirect_to post_icon_path(@posticon)
    else
      flash.now[:error] = "編集に失敗しました"
      render icons_url
    end
  end

  def destroy
    @posticon.destroy!
    redirect_to icons_path, status: :see_other
  end

  private

    def set_posticon
      @posticon = current_user.post_icons.find(params[:id])
    end

    def posticon_params
      params.require(:post_icon).permit(:title, :icon, :status)
    end
end
