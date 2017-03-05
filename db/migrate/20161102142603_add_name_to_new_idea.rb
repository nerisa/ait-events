class AddNameToNewIdea < ActiveRecord::Migration[5.0]
  def change
    add_column :new_ideas, :name, :string
  end
end
