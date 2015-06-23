class ReviewsController < ApplicationController
  before_action :authenticate_user!, only: [:create, :destroy]

  def create
    @review = current_user.reviews.build review_params
    if @review.save
      flash[:notice] = t "flashs.success"
    else
      flash[:alert] = t "flashs.notblank"
    end
    redirect_to request.referer || root_url
  end

  private
  def review_params
    params.require(:review).permit :book_id, :user_id, :review, :rate
  end
end
