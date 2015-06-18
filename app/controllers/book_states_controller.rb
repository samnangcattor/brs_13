class BookStatesController < ApplicationController
  before_action :authenticate_user!

  def create
    @book = Book.find params[:book_id]
    current_user.reading @book
    respond_to do |format|
      format.html {redirect @book}
      format.js
    end
  end

  def update
    @book_state = BookState.find params[:id]
    if @book_state.update_attributes book_state_param
      respond_to do |format|
        format.html {redirect @book}
        format.js
      end
    end
  end

  private
  def book_state_param
    params.require(:book_state).permit :state
  end
end
