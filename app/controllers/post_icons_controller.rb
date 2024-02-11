class PostIconsController < ApplicationController
  before_action :set_posticon, only: %i[destroy]
  def index
    @posticons = PostIcon.all.includes(:user).order(created_at: :desc)
  end

  def new
    @posticon = PostIcon.new
  end

  def create
    logger.debug params.inspect 
    @posticon = current_user.post_icons.build(posticon_params)
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
    redirect_to post_icons_path
  end

  private
    def set_posticon
      @posticon = current_user.post_icons.find(params[:id])
    end

    def posticon_params
      params.require(:post_icon).permit(:title)
    end

end
