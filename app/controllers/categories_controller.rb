class CategoriesController < ApplicationController
  before_action :authenticate_user!
  
  def show
    @category = Category.find params[:id]
    @books = @category.books.paginate page: params[:page]
  end
end
