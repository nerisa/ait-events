class Announcement < ApplicationRecord
  belongs_to :event

  default_scope { order(created_at: :desc) }

  validates_presence_of :description

end
