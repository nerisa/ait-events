class Volunteer < ApplicationRecord
  belongs_to :user
  belongs_to :event

  before_create do
    self.is_approved = false
  end

  validates_presence_of :user, :event
  validates_uniqueness_of :user, scope: :event

end
