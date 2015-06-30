class Admins::RequestBooksController < ApplicationController
  before_action :authenticate_admin!

  def index
    @request_books =  RequestBook.paginate page: params[:page] 
  end

  def update
    @request_book = RequestBook.find params[:id]
    @user = @request_book.user
    AcceptBook.perform_async  @user.id, @request_book.id
    if @request_book.update_attributes state: true
      respond_to do |format|
        format.html {redirect @request_book}
        format.js
      end
    end
  end
end
