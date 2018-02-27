class WikisController < ApplicationController
  before_action :authenticate_user!, except: [:show, :index]

  def new
    @wiki = Wiki.new
  end

  def index
    @wikis = Wiki.all.order(created_at: :desc)
  end

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

  def show
    begin
      @wiki = Wiki.find(params[:id])
    rescue ActiveRecord::RecordNotFound => e
      redirect_to wikis, flash.now[:error] = "Whoops! Could not find that wiki. \n #{e.message}"
    end
  end

  def update
    @wiki = Wiki.find(params[:id])
    @wiki.assign_attributes(wiki_params)

    if @wiki.save
      flash[:notice] = "Wiki was updated successfully."
      redirect_to @wiki
    else
      flash.now[:alert] = "Unable to save wiki. Please try again later."
      render :edit
    end
  end

  def edit
    @wiki = Wiki.find(params[:id])
  end

  def destroy
    @wiki = Wiki.find(params[:id])
    if @wiki.delete
      flash[:notice] = "\"#{@wiki.title}\" was deleted successfully."
      redirect_to wikis_path
    else
      flash.now[:alert] = "There was an error deleting the wiki"
      render :show
    end
  end

  private

  def wiki_params
    params.require(:wiki).permit(:title, :body, :private)
  end
end
