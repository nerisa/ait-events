class HomeController < ApplicationController

  skip_before_action :require_login

  def index
    @events = Event.all
    @events_by_date = @events.group_by{|ev| ev.start_date.to_date unless ev.start_date.nil?}
    @date = params[:date] ? Date.parse(params[:date]) : Date.today
  end
end
