class CollaboratorsController < ApplicationController
  include Devise::Controllers::Helpers
  before_action :authenticate_user!

  def new
    @users = User.all
    @collaborator = Collaborator.new
    @wiki = Wiki.find(params[:wiki_id])
  end

  def destroy
    @wiki = Wiki.find(params[:wiki_id])
    @collaborator = @wiki.collaborators.find(params[:id])
    @collaborator.delete
    redirect_to @wiki
  end

  private
  def collab_params
     params.require(:collaborator).(:collaborator, :attributes, :user_id)
  end
end
