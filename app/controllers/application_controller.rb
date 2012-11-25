class ApplicationController < ActionController::Base
  protect_from_forgery
  
  private

  def authorize_admin!
  	authenticate_user!
  	unless current_user.admin?
  		flash[:notice] = "You don't have the permission to do this"
  		redirect_to root_path
  	end
  end
end
