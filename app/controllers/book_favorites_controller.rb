class BookFavoritesController < ApplicationController
  before_action :authenticate_user!

  def index
    user = User.find params[:user_id]
    @book_favorites = user.book_favorites.paginate page: params[:page]
  end
  
  def create
    @book = Book.find params[:book_id]
    current_user.favourite @book
    respond_to do |format|
      format.html {redirect @book}
      format.js
    end
  end

  def destroy
    @book_favorite = BookFavorite.find params[:id]
    current_user.unfavourite @book_favorite
    respond_to do |format|
      format.html {redirect @book_favorite}
      format.js
    end
  end
end
