class Admins::BooksController < ApplicationController
before_action :authenticate_admin!

  def new
    @book = Book.new
    @categories = Category.all
    @authors = Author.all
  end

  def create
    @book = Book.new book_params
    if @book.save
      flash[:success] = t "flash.create_succes"
      redirect_to "#"
    else
      render "new"
    end
  end

private
  def book_params
    params.require(:book).permit :title, :publish_date, :page, author_ids: [], category_ids: []
  end
end
