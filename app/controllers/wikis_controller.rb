class WikisController < ApplicationController
  include Pundit
  before_action :authenticate_user!, except: [:show, :index]
  before_action :find_wiki, except: [:new, :index, :create]

  def new
    @wiki = Wiki.new
  end

  def index
    @wikis = policy_scope(Wiki)
  end

  def create
    @wiki = current_user.wikis.build(wiki_params)

    if @wiki.save
      redirect_to @wiki
    else
      flash.now[:alert] = "Unable to save wiki. Please try again later"
      render :new
    end
  end

  def show
    begin
      authorize @wiki, :show?
    rescue Pundit::NotAuthorizedError => e
      redirect_to wikis, flash.now[:alert] = "You do not have permission to do that."
    end
  end

  def update
    @wiki authorize, :update?
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
  end

  def destroy
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

  def find_wiki
    begin
      @wiki =  Wiki.find(params[:id])
    rescue ActiveRecord::RecordNotFound => e
      redirect_to wikis, flash.now[:error] = "Whoops! Could not find that wiki. \n #{e.message}"
    end
  end
end
