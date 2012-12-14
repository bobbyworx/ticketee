class Admin::PermissionsController < Admin::BaseController
	before_filter :find_user

	def find_user
		@user = User.find(params[:user_id])
	end
	
	def index
		@ability = Ability.new(@user)
		@projects = Project.all
	end

	def update
		@user.permissions.clear
		params[:permissions].each do |id, permissions|
		project = Project.find(id)
		permissions.each do |permission, checked|
		Permission.create!(:user => @user, :thing => project, :action => permission)
		end
	end
		flash[:notice] = "Permissions updated."
		redirect_to admin_user_permissions_path
	end
end
