class BooksController < ApplicationController
  before_action :authenticate_user!

  def index
    @search = Book.search params[:q]
    @books = @search.result
  end

  def show
    @book = Book.find params[:id]
    @categories = @book.categories
    @authors = @book.authors
    @review = @book.reviews.build
    @reviews = @book.reviews.paginate page: params[:page]
  end
end
