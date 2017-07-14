class TicketRirekisController < ApplicationController
  def index
  	@tickets = Ticket.where(:user_id => current_user.id).order(:created_at => 'desc').all
  end

  def new
  end

  def show
  end

  def edit
  end
end
