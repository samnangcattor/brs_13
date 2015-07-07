class CommentsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_comment, only: [:edit, :update, :destroy]
  
  def create
    @comment = current_user.comments.build comment_params
    if @comment.save
      CommentsWorker.perform_async @comment.id
      flash[:notice] = t "flashs.success"
    else
      flash[:alert] = t "flashs.notblank"
    end
    redirect_to request.referer || root_url
  end

  def edit
  end

  def update
    if @comment.update_attributes comment_params
      flash[:notice] = t "flashs.success"
      redirect_to @comment.review
    else
      render "edit"
      flash[:alert] = t "flashs.notblank"
      redirect_to request.referer || root_url
    end
  end

  def destroy
    @comment.destroy
    flash[:alert] = t "flashs.comment_delete"
    redirect_to request.referer || root_url
  end

  private
  def set_comment
    @comment = Comment.find params[:id]
  end
  
  def comment_params
    params.require(:comment).permit :user_id, :review_id, :comment
  end
end
