class Event < ApplicationRecord
  belongs_to :committee
  has_many :announcements, dependent: :destroy

  has_many :volunteers
  has_many :users, through: :volunteers

  validates_presence_of :name, message: 'Please enter a name for the event.'
  validates_presence_of :description, message: 'Please enter a description for the event.'
  validates_presence_of :committee, message: 'Please select a committee under which this event falls under.'

  validate :validate_event_dates, on: :create

  def validate_event_dates
    errors.add(:start_date, "Event cannot start in the past.") if !start_date.blank? and start_date < Date.today
    if (!end_date.blank? and end_date < Date.today)
      errors.add(:end_date, "Event cannot end in the past.")
    elsif (!start_date.blank? and !end_date.blank? and end_date < start_date)
      errors.add(:end_date, "Event cannot end before it starts.")
    end
  end

  before_destroy :delete_volunteers

  def delete_volunteers
    volunteers = Volunteer.where(event: itself)
    volunteers.delete_all
  end

  def isInFuture
    if !self.start_date.nil?
      if(self.start_date < DateTime.current)
        return false
      else
        return true
      end
    else
      return false
    end
  end
end
