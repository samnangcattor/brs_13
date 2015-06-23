class BooksController < ApplicationController
  before_action :authenticate_user!

  def index
    @books =  Book.paginate page: params[:page]
  end

  def show
    @book = Book.find params[:id]
    @categories = @book.categories
    @authors = @book.authors
    @review = @book.reviews.build
    @reviews = @book.reviews.paginate page: params[:page]
  end
end
