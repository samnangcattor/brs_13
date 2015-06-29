class ReviewsController < ApplicationController
  before_action :authenticate_user!, only: [:create, :destroy]

  def show
    @review = Review.find params[:id]
    @comments = @review.comments.paginate page: params[:page]
    @comment = @review.comments.build
  end
  
  def create
    @review = current_user.reviews.build review_params
    if @review.save
      flash[:notice] = t "flashs.success"
    else
      flash[:alert] = t "flashs.notblank"
    end
    redirect_to request.referer || root_url
  end

  def edit
    @review = Review.find params[:id]
  end

  def update
    @review = Review.find params[:id]
    if @review.update_attributes review_params
      flash[:notice] = t "flashs.success"
      redirect_to @review.book
    else
      flash[:alert] = t "flashs.notblank"
      render "edit"
    end
  end

  def destroy
    @review = Review.find params[:id]
    @review.destroy
    flash[:notice] = t "flashs.rev_delete"
    redirect_to request.referer || root_url
  end

  private
  def review_params
    params.require(:review).permit :book_id, :user_id, :review, :rate
  end
end
