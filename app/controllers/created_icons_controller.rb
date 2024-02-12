class CreatedIconsController < ApplicationController
  before_action :set_createdicon, only: %i[destroy]

  def new
    @createdicon =  CreatedIcon.new
  end

  def create
    @createdicon = current_user.created_icons.build(createdicon_params)
    prompt = @createdicon.title
    image_key = OpenaiService.download_image(prompt)
    @createdicon.icon.attach(ActiveStorage::Blob.find_by(key: image_key)) if image_key
    if @createdicon.save
      flash[:success] = "Micropost created!"
      redirect_to created_icons_url
    else
      render :new, status: :unprocessable_entity
    end
  end

  def show
    @createdicon = CreatedIcon.find(params[:id])
  end

  def destroy
    @createdicon.destroy!
    redirect_to created_icons_path
  end

  private
    def set_createdicon
      @createdicon = current_user.created_icons.find(params[:id])
    end

    def createdicon_params
      params.require(:created_icon).permit(:title, :taste, :icon)
    end

end
