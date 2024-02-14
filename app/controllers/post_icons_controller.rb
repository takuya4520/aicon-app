class PostIconsController < ApplicationController
  before_action :set_posticon, only: %i[destroy]

  def new
    @posticon = PostIcon.new
  end

  def create
    @posticon = current_user.post_icons.build(posticon_params)
    @posticon.icon.attach(params[:post_icon][:icon])
    if @posticon.save
      flash[:success] = "Micropost created!"
      redirect_to post_icons_url
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
