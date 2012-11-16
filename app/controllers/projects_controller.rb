class ProjectsController < ApplicationController

def index
	@projects = Project.all
end

def new
	@project = Project.new
end

def create
	@project = Project.new
	if @project.save
		flash[:notice] = "Project has been created"
		redirect_to @project
	else
		flash[:notice] = "Project has not been created"
		redirect_to :action => "new"
	end
end

def show
	@project = Project.find(params[:id])
end

def edit
	@project = Project.find(params[:id])
end

def update
	@project = Project.find(params[:id])
	if @project.update_attributes(params[:project])
		flash[:notice] = "Project has been updated"
		redirect_to @project
	else
		flash[:notice] = "Project has not been updated"
		redirect_to :action => "edit"
	end
end

end
