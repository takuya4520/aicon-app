class PostIconsController < ApplicationController
  before_action :set_posticon, only: %i[edit update destroy]

  def new
    @posticon = PostIcon.new
  end

  def create
    @posticon = current_user.post_icons.build(posticon_params)
    @posticon.icon.attach(params[:post_icon][:icon])
    if @posticon.save
      flash[:success] = "Micropost created!"
      redirect_to post_icon_url(@posticon)
    else
      render :new, status: :unprocessable_entity
    end
  end

  def show
    @posticon= PostIcon.find(params[:id])
  end

  def edit
  end

  def update
    if @posticon.update(posticon_params)
      redirect_to icons_url, notice: "アウトプットを編集しました"
    else
      flash.now[:danger] = "編集に失敗しました"
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
      params.require(:post_icon).permit(:title,:icon)
    end
end
