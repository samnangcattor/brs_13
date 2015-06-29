class Admins::ReviewsController < ApplicationController
  before_action :authenticate_admin!
  
  def show
    @review = Review.find params[:id]
    @comments = @review.comments.paginate page: params[:page]
    @book = @review.book
  end
end
