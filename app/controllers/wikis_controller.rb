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
  
    if @wiki.save
      flash[:notice] = 'Wiki was updated successfully.'
      redirect_to @wiki
    else
      flash.now[:alert] = 'There was an error saving the wiki. Please try again.'
      render :edit
    end
  end

  def destroy
    @wiki = Wiki.find(params[:id])

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
