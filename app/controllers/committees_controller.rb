class CommitteesController < ApplicationController

  skip_before_action :require_login

  def show
    @committee = Committee.find (params[:id])
    @upcoming_event = Event.where("start_date > ? AND start_date < ? AND committee_id = ?",Time.now,2.weeks.since,@committee.id).order(:start_date).first
    @events = Event.where(committee: @committee).order(start_date: :desc)

  end



end
