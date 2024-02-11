class PostIconsController < ApplicationController
  def index
  end

  def new
    @posticon = PostIcon.new
  end

  def create
    logger.debug params.inspect 
    @posticon = current_user.post_icons.build(posticon_params)
    if @posticon.save
      flash[:success] = "Micropost created!"
      redirect_to root_url
    else
      render :new, status: :unprocessable_entity
    end
  end

  def show
  end

  def edit
  end

  def update
  end

  def destroy
  end

  private

    def posticon_params
      params.require(:post_icon).permit(:title)
    end

end
