class Admins::AuthorsController < ApplicationController
  before_action :authenticate_admin!
  before_action :set_author, except: [:index, :new, :create]

  def index
    @authors =  Author.paginate page: params[:page]
  end

  def new
    @author = Author.new
  end

  def create
    @author = Author.new author_params
    if @author.save
      flash[:notice] = t "flashs.addauthor"
    else
      flash[:alert] = t "flashs.blankauthor"
    end
    redirect_to request.referer || root_url
  end

  def edit
    @authors =  Author.paginate page: params[:page] 
  end

  def update
    if @author.update_attributes author_params
      flash[:notice] = t "flashs.deleteauthor"
      redirect_to request.referer || root_url
    else
      render "edit"
    end
  end

  def destroy
    @author.destroy
    flash[:alert] = t "flashs.deleteauthor"
    redirect_to request.referer || root_url
  end

  private
  def author_params
    params.require(:author).permit :name
  end

  def set_author
    @author = Author.find params[:id]
  end
end
