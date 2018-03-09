class CollaboratorsController < ApplicationController
  include Devise::Controllers::Helpers
  before_action :authenticate_user!

  def new
    @users = User.all
    @collaborator = Collaborator.new
    @wiki = Wiki.find(params[:wiki_id])
  end

  # def create
  #   #@wiki = Wiki.find(params[:wiki_id])
  #   #@user = User.find(params[:user_id])
  #   @collaborator = Collaborator.new collab_params
  #   if @collaborator.save
  #     flash[:notice] = "Collaborator successfully added."
  #   else
  #     flash[:alert] = "Could not add collaborator."
  #   end
  #   redirect_to @wiki
  # end

  def destroy
    wiki = Wiki.find(params[:wiki_id])
    @collaborator = Collaborator.find(params[:id])
    #authorize @collaborator, :destroy?
    if @collaborator.delete
    flash[:notice] = "\"#{@collaborator.user.name}\" was removed successfully."
      refresh
    else
      flash.now[:alert] = "There was an error removing this collaborator"
      refresh
    end
  end

  private
  def collab_params
     params.require(:collaborator).(:collaborator, :attributes, :user_id)
  end
end
