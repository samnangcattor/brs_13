class Admins::RequestBooksController < ApplicationController
  before_action :authenticate_admin!

  def index
    @request_books =  RequestBook.paginate page: params[:page] 
  end

  def destroy
    @request_book = RequestBook.find params[:id]
    @request_book.destroy
    flash[:alert] = t "flashs.cancelrequest"
    redirect_to request.referer || root_url
  end
end
