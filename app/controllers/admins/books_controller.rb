class Admins::BooksController < ApplicationController
before_action :authenticate_admin!
before_action :set_book, except: [:index, :new, :create]

  def index
   @books =  Book.paginate page: params[:page] 
  end

  def new
    @book = Book.new
    @categories = Category.all
    @authors = Author.all
  end

  def create
    @book = Book.new book_params
    @books = Book.paginate page: params[:page]
    if @book.save
      flash[:notice] = t "flashs.addbook"
      render "index"
    else
      render "new"
    end
  end

  def edit
    @categories = Category.all
    @authors = Author.all
  end

  def update
    if @book.update_attributes book_params
      flash[:notice] = t "titles.author"
      redirect_to [:admins, @book]
    else
      render "edit"
    end
  end

  def show
    @categories = @book.categories
    @authors = @book.authors
    @reviews = @book.reviews.paginate page: params[:page]
  end

  def destroy
    @book.destroy
    flash[:success] = t "flashs.delete"
    redirect_to request.referer || root_url
  end

private
  def book_params
    params.require(:book).permit :title, :publish_date, :page, author_ids: [], category_ids: []
  end

  def set_book
    @book = Book.find params[:id]
  end
end
