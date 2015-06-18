class Admins:SessionsController < Desive::SessionsController
  def new
    super
  end

  def create
    user = User.find_by email: params[:admin][:email]
    unless user && user.admin?
      redirect_to new_admin_session_path, flash: {danger: t("flashs.login")}
    end
  end
end
