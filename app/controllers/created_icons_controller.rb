class CreatedIconsController < ApplicationController
  skip_before_action :require_login, only: %i[show]
  before_action :set_createdicon, only: %i[edit update destroy]

  def new
    @createdicon =  CreatedIcon.new
  end

  def create
    @createdicon = current_user.created_icons.build(createdicon_params)
    image_key = OpenaiService.download_image(@createdicon)
    @createdicon.icon.attach(ActiveStorage::Blob.find_by(key: image_key)) if image_key
    if @createdicon.save
      flash[:success] = "アイコンが生成されました"
      redirect_to created_icon_path(@createdicon)
    else
      flash.now[:danger] = "アイコンの生成に失敗しました"
      render :new, status: :unprocessable_entity
    end
  end

  def show
    @createdicon = CreatedIcon.find(params[:id])
  end

  def edit
  end

  def update
    if @createdicon.update(createdicon_params)
      flash[:success] = "アイコンを編集しました"
      redirect_to created_icon_path(@createdicon)
    else
      flash.now[:danger] = "編集に失敗しました"
      render icons_url
    end
  end

  def destroy
    @createdicon.destroy!
    redirect_to icons_path, status: :see_other
  end

  private
    def set_createdicon
      @createdicon = current_user.created_icons.find(params[:id])
    end

    def createdicon_params
      params.require(:created_icon).permit(:title, :taste, :icon, :status)
    end

end
