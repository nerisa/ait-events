class Committee < ApplicationRecord
  belongs_to :user
  has_many :events

  validates_presence_of :name, :description

end
