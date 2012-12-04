class ProjectsController < ApplicationController
	before_filter :authorize_admin!, :except => [:index, :show]
	before_filter :authenticate_user!, :only => [:show]
	before_filter :find_project, :only => [:show, :edit, :update, :destroy]

def find_project
	@project = if current_user.admin?
		Project.find(params[:id])
	else
		Project.readable_by(current_user).find(params[:id])
end

end

def index
	@projects = Project.all
end

def new
	@project = Project.new
end

def create
	@project = Project.new(params[:project])
	if @project.save
		flash[:notice] = "Project has been created"
		redirect_to @project
	else
		flash[:notice] = "Project has not been created"
		redirect_to :action => "new"
	end
end

def show
end

def edit
end

def update
	if @project.update_attributes(params[:project])
		flash[:notice] = "Project has been updated"
		redirect_to @project
	else
		flash[:notice] = "Project has not been updated"
		redirect_to :action => "edit"
	end
end

def destroy
	@project.destroy
	flash[:notice] = "Project has been deleted"
	redirect_to projects_path
end

end
