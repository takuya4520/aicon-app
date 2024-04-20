class Admin::BaseController < ApplicationController
  before_action :check_admin
  layout 'admin/layouts/application'

  private

  def not_authenticated
    flash[:warning] = "管理者ログインをしてください"
    redirect_to admin_login_path
  end

  def check_admin
    redirect_to root_path unless current_user.admin?
  end
end
