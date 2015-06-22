class RelationshipsController < ApplicationController
  before_action :authenticate_user!, only: [:index, :create, :destroy]

  def index
    status = params[:status]
    @user  = User.find params[:id]
    @title = status.capitalize
    @users = @user.send("#{status}").paginate page: params[:page]
  end

  def create
    @user = User.find params[:followed_id]
    current_user.follow @user
    respond_to do |format|
      format.html {redirect_to @user}
      format.js
    end
  end

  def destroy
    @user = Relationship.find(params[:id]).followed
    current_user.unfollow @user
    respond_to do |format|
      format.html {redirect_to @user}
      format.js
    end
  end
end
