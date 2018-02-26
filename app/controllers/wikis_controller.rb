class WikisController < ApplicationController
  before_action :authenticate_user!, except: [:show, :index]

  def create
    @wiki = current_user.wiki.build(wiki_params)
    @wiki.user = current_user

    if @wiki.save
      redirect_to @wiki
    else
      flash.now[:alert] = "Unable to save wiki. Please try again later"
      render :new
    end
  end

  def update
    @wiki = Wiki.find(params[:id])
  end

  def delete
    @wiki = Wiki.find(params[:id])
  end

  def show
    @wiki = Wiki.find(params[:id])
  end

  def new
    @wiki = Wiki.new
  end

  def index
    @wikis = Wiki.all.order(created_at: :desc)
  end
  private
  def wiki_params
    params.require(:wiki).permit(:title, :body, :private)
  end
end
