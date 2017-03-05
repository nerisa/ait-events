class NewIdea < ApplicationRecord

  belongs_to :committee
  belongs_to :user
  has_many :comments

  before_create :default_values

  validates_presence_of :description, :user, :committee, :name

  def default_values
    self.restrict_display = false
    self.is_closed = false
  end

  def author
    self.user
  end
end
