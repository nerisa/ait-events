class AnnouncementsController < ApplicationController

  before_action :get_event

  load_and_authorize_resource :event
  load_and_authorize_resource :announcement, :through => :event

  def create
    logger.info("Adding announcement for event #{@event.id} with params #{params.inspect}")
    @announcement = @event.announcements.build(resource_params)
    if(!@announcement.valid?)
      logger.debug("Could not save announcement #{@announcement.errors.inspect}")
      @errorMsg = "Your announcement could not be posted. Please check your inputs."
      return
    end
    @announcement.save
  end

  def edit
    @announcement = Announcement.find(params[:id])
  end

  def update
    @announcement = Announcement.find(params[:id])
    @announcement.update(resource_params)
  end

  def destroy
    @announcement = Announcement.find(params[:id])
    @id = @announcement.id
    @announcement.destroy
  end

  private

  def get_event
    @event = Event.find(params[:event_id])
  end

  def resource_params
    params.require(:announcement).permit(:description)
  end
end
