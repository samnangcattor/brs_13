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
      flash[:success] = t "flash.create_succes"
      redirect_to request.referer || root_url
    else
      render "new"
    end
  end

  def edit
    @authors =  Author.paginate page: params[:page] 
  end

  def update
    if @author.update_attributes author_params
      flash[:info] = t "titles.author"
      redirect_to request.referer || root_url
    else
      render "edit"
    end
  end

  def destroy
    @author.destroy
    flash[:success] = t "flashs.delete"
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
