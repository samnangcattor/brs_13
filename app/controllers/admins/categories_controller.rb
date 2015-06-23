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
      flash[:notice] = t "flashs.addcategory"
    else
      flash[:alert] = t "flashs.categoryblank"
    end
    redirect_to request.referer || root_url
  end

  def edit
    @categories =  Category.paginate page: params[:page] 
  end

  def update
    if @category.update_attributes category_params
      flash[:notice] = t "flashs.updatecategory"
      redirect_to request.referer || root_url
    else
      render "edit"
    end
  end

  def destroy
    @category.destroy
    flash[:alert] = t "flashs.deletecategory"
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
