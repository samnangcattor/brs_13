class Admins::UsersController < ApplicationController
  before_action :authenticate_admin!

  def index
    @users =  User.paginate page: params[:page]
  end
end
