class Admins::SessionsController < Devise::SessionsController
  before_action :check_admin, only: [:create]

  def new
    super
  end

  def create
    super
  end

  private
  def check_admin
    user = User.find_by email: params[:admin][:email]
    unless user && user.admin?
      flash[:danger] = t("flashs.login")
      redirect_to new_admin_session_path
    end
  end
end
