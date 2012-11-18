class TicketsController < ApplicationController
	
	before_filter :find_project
	before_filter :find_ticket, :only => [:show, :edit, :update, :destroy]

	def new
		@ticket = @project.tickets.build
	end

	def find_project
		@project = Project.find(params[:project_id])
	end

	def create
		@ticket = @project.tickets.build(params[:ticket])
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
end

