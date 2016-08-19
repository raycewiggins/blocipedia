class WikisController < ApplicationController
  def index
    if current_user
      @wikis = policy_scope(Wiki)
    else
      flash[:alert] = 'You must have an account to view Wikis. Sign up below to get started.'
      redirect_to root_path
    end
  end

  def show
    @user = current_user
    @wiki = Wiki.find(params[:id])
    # if the user is not a collaborator and not the author they cannot view the wiki
    if @wiki.users == [] && @wiki.user_id != @user.id
      flash[:alert] = 'You must be the original author or a collaborator to view that wiki.'
      redirect_to root_path
    end
  end

  def new
    @wiki = Wiki.new
  end

  def create
    @wiki = Wiki.new(wiki_params)
    @wiki.user = current_user

    if @wiki.save
      @wiki.users = User.update_users(params[:wiki][:users])
      flash[:notice] = 'Wiki was saved successfully.'
      redirect_to @wiki
    else
      flash.now[:alert] = 'There was an error saving the wiki. Please try again.'
      render :new
    end
  end

  def edit
    @wiki = Wiki.find(params[:id])
  end

  def update
    @wiki = Wiki.find(params[:id])
    @wiki.assign_attributes(wiki_params)
    authorize @wiki
    #if the user is a standard collaborator they should not be able to update the collaborators on a wiki
    if @wiki.save && current_user.premium?
      @wiki.users = User.update_users(params[:wiki][:users])
      flash[:notice] = 'Wiki was updated successfully.'
      redirect_to @wiki
    elsif @wiki.save
      flash[:notice] = 'Wiki was updated successfully.'
      redirect_to @wiki
    else
      flash.now[:alert] = 'There was an error saving the wiki. Please try again.'
      render :edit
    end
  end

  def destroy
    @wiki = Wiki.find(params[:id])
    authorize @wiki

    if @wiki.destroy
      flash[:notice] = "\"#{@wiki.title}\" was deleted successfully."
      redirect_to wikis_path
    else
      flash.now[:alert] = 'There was an error deleting the wiki.'
      render :show
    end
  end

  private

   def wiki_params
    params.require(:wiki).permit(:title, :body, :private)
   end
end
