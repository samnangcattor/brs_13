class CommentsController < ApplicationController
  before_action :authenticate_user!, only: [:create, :destroy]
  
  def create
    @comment = current_user.comments.build comment_params
    if @comment.save
      flash[:notice] = t "flashs.success"
    else
      flash[:alert] = t "flashs.notblank"
    end
    redirect_to request.referer || root_url
  end

  private
  def comment_params
    params.require(:comment).permit :user_id, :review_id, :comment
  end
end
