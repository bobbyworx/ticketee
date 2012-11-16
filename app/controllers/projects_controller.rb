class ProjectsController < ApplicationController

def index
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

end
