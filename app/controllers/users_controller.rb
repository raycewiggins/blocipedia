class UsersController < ApplicationController
  def update
    downgrade_account
    flash[:notice] = "\"#{current_user.email}\" has been successfully downgraded to standard."
    redirect_to root_path
  end
end
