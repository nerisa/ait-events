class VolunteersController < ApplicationController

  before_action :get_event

  def index
    @volunteers = Volunteer.where(event: @event)
  end

  def add_volunteer
    logger.info("Adding volunteer request for #{current_user.username}")
    @volunteer = Volunteer.new(user: current_user)
    @event.volunteers << @volunteer
    @volunteer.save
  end

  def accept_volunteer
    @volunteer = Volunteer.find(params[:id])
    @volunteer.is_approved = true
    @volunteer.save
    flash[:message] = "User #{@volunteer.user.username} has been added to the volunteer list."
    redirect_to event_volunteers_path(@event)
  end

  def reject_volunteer
    @volunteer = Volunteer.find(params[:id])
    @volunteer.is_approved = false
    @volunteer.save
    flash[:message] = "User #{@volunteer.user.username} has been removed from the volunteer list."
    redirect_to event_volunteers_path(@event)
  end

  private

  def get_event
    @event = Event.find(params[:event_id])
  end

end
