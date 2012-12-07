class TicketsController < ApplicationController
	
	before_filter :find_project
	before_filter :find_ticket, :only => [:show, :edit, :update, :destroy]
  before_filter :authenticate_user!
  before_filter :authorize_create!, :only=> [:new, :create]

	def new
		@ticket = @project.tickets.build
	end

  def authorize_create!
    if !current_user.admin? && cannot?("create tickets".to_sym, @project)
    flash[:alert] = "You don't have the permission to create tickets"
    redirect_to @project
    end 
  end
  
	def find_project
		@project = Project.find(params[:project_id])
	end

	def create
		@ticket = @project.tickets.build(params[:ticket])
    @ticket.user_id = current_user.id
		if @ticket.save
			flash[:notice] = "Ticket has been created"
			#redirect_to[@project, @ticket]
			redirect_to project_ticket_path(@project, @ticket)
		else
			flash[:notice] = "Ticket has not been created"
			redirect_to :action => "new"
		end
	end

  def find_ticket
  	@ticket = @project.tickets.find(params[:id])
  end

  def show
  end

  def edit
  end

  def update
  	if @ticket.update_attributes(params[:ticket])
  		flash[:notice] = "Ticket has been updated"
  		redirect_to project_ticket_path(@project, @ticket)
  	else
  		flash[:notice] = "Ticket has not been updated"
  		redirect_to :action => "edit"
  	end
  end

  def destroy
  	@ticket.destroy
  	flash[:notice] = "Ticket has been deleted"
  	redirect_to @project
  end
end

