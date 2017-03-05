class NewIdeasController < ApplicationController

  load_and_authorize_resource

  before_action :load, except: [:show, :close_idea, :ban_idea]

  def index
    @user_volunteers = Volunteer.where(user: current_user, is_approved: true)
    @upcoming_volunteers = []
    @user_volunteers.each do |volunteer|
      if volunteer.event.start_date > DateTime.current
        @upcoming_volunteers << volunteer
      end
    end
    @upcoming_events = []
    if (!@upcoming_volunteers.empty?)
      event_ids = []
      @upcoming_volunteers.each do |volunteer|
        event_ids << volunteer.event.id
      end
      @upcoming_events = Event.where("start_date > ? AND start_date < ? AND id NOT IN (?) ",Time.now,2.weeks.since, event_ids).order(:start_date)
    else
      @upcoming_events = Event.where("start_date > ? AND start_date < ?",Time.now,2.weeks.since).order(:start_date)
    end

  end

  def create
    @new_idea = NewIdea.new(resource_params)
    @new_idea.user = current_user
    logger.info("Creating a new idea #{@new_idea.attributes.inspect}")
    if (!@new_idea.valid?)
      logger.debug("Could not save the idea #{@new_idea.errors.inspect}")
      @errorMsg = 'Your idea could not be submitted. Please check your inputs.'
      return
    end
    @new_idea.save
    logger.info("Created a new idea #{@new_idea.id}")
    @msg = 'Your idea has been submitted.'
    @ideaList = getRecentIdeas(5)
  end

  def show
    logger.info "inside show #{params.inspect}"
    @idea = NewIdea.find(params[:id])
    @ideaList= NewIdea.all.order(created_at: :desc)
    @comment =  @idea.comments.build
  end


  def close_idea
    @idea = NewIdea.find(params[:new_idea_id])
    @idea.is_closed = true
    @idea.save
  end

  def ban_idea
    @idea = NewIdea.find(params[:new_idea_id])
    @idea.restrict_display = true
    @idea.save
  end

  private

  def resource_params
    params.require(:new_idea).permit(:name, :description, :committee_id)
  end

  def getRecentIdeas(limitParams = NIL)
    if(limitParams)
      NewIdea.all.where("restrict_display = false AND is_closed = false").order(created_at: :desc).limit(limitParams)
    else
      NewIdea.all.where("restrict_display = false AND is_closed = false").order(created_at: :desc)
    end

  end

  def load
    @new_idea = NewIdea.new
    @ideaList = getRecentIdeas(5)
  end
end
