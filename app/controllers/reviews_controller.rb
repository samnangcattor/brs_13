class ReviewsController < ApplicationController
  before_action :authenticate_user!, only: [:create, :destroy]
  before_action :set_review, except: [:new, :create]

  def show
    @comments = @review.comments.paginate page: params[:page]
    @comment = @review.comments.build
  end
  
  def create
    @review = current_user.reviews.build review_params
    if @review.save
      ReviewsWorker.perform_async params[:review][:book_id]
      flash[:notice] = t "flashs.success"
    else
      flash[:alert] = t "flashs.notblank"
    end
    redirect_to request.referer || root_url
  end

  def edit
  end

  def update
    if @review.update_attributes review_params
      flash[:notice] = t "flashs.success"
      redirect_to @review.book
    else
      flash[:alert] = t "flashs.notblank"
      render "edit"
    end
  end

  def destroy
    @review.destroy
    flash[:notice] = t "flashs.rev_delete"
    redirect_to request.referer || root_url
  end

  private
  def set_review
    @review = Review.find params[:id]
  end

  def review_params
    params.require(:review).permit :book_id, :user_id, :review, :rate
  end
end
