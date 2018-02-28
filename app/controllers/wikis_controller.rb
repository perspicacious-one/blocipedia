class WikisController < ApplicationController
  include Pundit
  before_action :authenticate_user!, except: [:show, :index]

  def new
    @wiki = Wiki.new
  end

  def index
    @wikis = policy_scope(Wiki)
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
      authorize @wiki, :show?
    rescue ActiveRecord::RecordNotFound => e
      redirect_to wikis, flash.now[:error] = "Whoops! Could not find that wiki. \n #{e.message}"
    end
  end

  def update
    @wiki = authorize Wiki.find(params[:id]), :update?
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
    @wiki =  Wiki.find(params[:id])
    authorize @wiki, :destroy?
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