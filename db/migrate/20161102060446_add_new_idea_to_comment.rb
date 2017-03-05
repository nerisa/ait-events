class AddNewIdeaToComment < ActiveRecord::Migration[5.0]
  def change
    add_reference :comments, :new_idea, foreign_key: true
  end
end
