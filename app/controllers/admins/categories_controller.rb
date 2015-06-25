class Admins::CategoriesController < ApplicationController
  before_action :authenticate_admin!
  before_action :set_category, except: [:index, :new, :create]

  def index
    @categories = Category.paginate page: params[:page]
  end
  
  def new
    @category = Category.new
  end

  def create
    @category = Category.new category_params
    if @category.save
      flash[:success] = t "flash.create_succes"
      redirect_to request.referer || root_url
    else
      render "new"
    end
  end

  def edit
    @categories =  Category.paginate page: params[:page] 
  end

  def update
    if @category.update_attributes category_params
      flash[:info] = t "titles.category"
      render "new"
    else
      render "edit"
    end
  end

  def destroy
    @category.destroy
    flash[:success] = t "flashs.delete"
    redirect_to request.referer || root_url
  end

  private
  def category_params
    params.require(:category).permit :name
  end

  def set_category
    @category = Category.find params[:id]
  end
end
