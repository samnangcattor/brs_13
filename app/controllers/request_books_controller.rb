class RequestBooksController < ApplicationController
  before_action :authenticate_user!
  before_action :request_book_params, only: [:edit, :update, :destroy]

  def index
    user = User.find params[:user_id]
    @request_books = user.request_books.paginate page: params[:page]
  end

  def new
    @request_book = RequestBook.new
  end

  def create
    @request_book = current_user.request_books.build request_params
    if @request_book.save
      flash[:alert] = t "flashs.request"
      redirect_to request.referer || root_url
    else
      render "new"
    end
  end

  def edit
  end

  def update 
    if @request_book.update_attributes request_params
      flash[:alert] = t "flashs.update"
    else
      flash[:alert] = t "flashs.failed_update"
    end
    redirect_to request.referer || root_url
  end

  def destroy
    @request_book.destroy
    flash[:alert] = t "flashs.delete_request"
    redirect_to request.referer || root_url
  end

  private
  def request_params
    params.require(:request_book).permit :name, :description
  end
  
  def request_book_params
    @request_book = RequestBook.find params[:id]
  end
end
