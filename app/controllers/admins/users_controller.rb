class Admins::UsersController < ApplicationController
  before_action :authenticate_admin!

  def index
    @users =  User.paginate page: params[:page]
  end

  def show
    @user = User.find params[:id]
  end
  
  def destroy
    @user = User.find params[:id]
    @user.destroy
    flash[:success] = t("flashs.delete")
    redirect_to request.referer || root_url
  end
end
