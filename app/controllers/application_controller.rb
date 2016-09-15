class ApplicationController < ActionController::Base
  include Pundit
  rescue_from Pundit::NotAuthorizedError, with: :user_not_authorized

  protect_from_forgery with: :exception

  
  private

  def user_not_authorized
    flash.now[:alert] = 'You are not authorized to perform this action. See About Page for more details'
    render :show
  end

  def upgrade_account
    @user = current_user
    @user.role = 1
    @user.save
  end

  def downgrade_account
    @user = current_user
    @wikis = @user.wikis
    @wikis.each do |wiki|
      wiki.update_attribute(:private, false)
      wiki.save
    end
    @user.role = 0
    @user.save
  end
end
