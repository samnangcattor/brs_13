class BookFavoritesController < ApplicationController
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
