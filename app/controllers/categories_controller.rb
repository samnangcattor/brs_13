class CategoriesController < ApplicationController
  before_action :authenticate_user!
  
  def index
    @search = Category.search params[:q]
    @categories = @search.result
  end

  def show
    @category = Category.find params[:id]
    @books = @category.books.paginate page: params[:page]
  end
end
