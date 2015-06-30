class LikesController < ApplicationController
  before_action :authenticate_user!

  def create
    @activity = Activity.find params[:activity_id]
    current_user.like @activity
    respond_to do |format|
      format.html {redirect_to @activity}
      format.js
    end
  end

  def destroy
    @like = Like.find_by(activity_id: params[:id]).destroy 
    respond_to do |format|
      format.html {redirect_to @activity}
      format.js
    end
  end
end
