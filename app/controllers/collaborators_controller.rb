class CollaboratorsController < ApplicationController
  def show
     @user = User.find(params[:id])
     @wikis = Wiki.all.where(user_id: current_user.id)
  end
end
