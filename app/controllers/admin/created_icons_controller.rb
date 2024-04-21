class Admin::CreatedIconsController < Admin::BaseController
  before_action :set_user, only: %i[edit update destroy]
  def index
  end
end