class EventsController < ApplicationController

  load_and_authorize_resource
  skip_before_action :require_login, only: [:show, :index]

  def index
    @events = Event.all
    @events_by_committee = @events.group_by(&:committee)
  end

  def show
    @event = Event.find(params[:id])
    @announcements = @event.announcements
    @announcement = @event.announcements.build
  end

  def new
    @event = Event.new
  end

  def edit
    @event = Event.find(params[:id])
  end

  def update
    @event = Event.find(params[:id])
    if @event.update(resource_params)
      flash[:message] = 'Your event has been updated successfully.'
      redirect_to @event
    else
      logger.debug "Error in event data while updating: #{@event.errors.inspect}"
      render action: 'edit'
    end
  end

  def create
    @event = Event.new(resource_params)
    if (current_user.is_master_admin?)
      committee = Committee.find_by user: current_user
      @event.committee = committee
    end
    if @event.save
      flash[:message] = 'Your event has been created successfully.'
      redirect_to @event
    else
      render action: 'new'
    end
  end

  def destroy
    @event = Event.find(params[:id])
    event_name = @event.name
    event_committee = @event.committee
    @event.destroy
    flash[:message] = "Your event #{event_name} has been deleted."
    if(current_user.is_master_admin?)
      redirect_to committee_path(event_committee)
    else
      redirect_to events_path
    end
  end

  private

  def resource_params
    params.require(:event).permit(:committee_id, :name, :description, :start_date, :end_date, :venue, )
  end

end
