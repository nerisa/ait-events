class Comment < ApplicationRecord

  belongs_to :user
  belongs_to :new_idea

  validates_presence_of :description, :user, :new_idea

  default_scope { order(updated_at: :desc) }
end
