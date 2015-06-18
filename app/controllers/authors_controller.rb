class AuthorsController < ApplicationController
  before_action :authenticate_user!
  
  def show
    @author = Author.find params[:id]
    @books = @author.books.paginate page: params[:page]
  end
end
