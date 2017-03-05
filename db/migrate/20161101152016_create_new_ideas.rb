class CreateNewIdeas < ActiveRecord::Migration[5.0]
  def change
    create_table :new_ideas do |t|
      t.text :description
      t.boolean :is_closed
      t.boolean :restrict_display
      t.references :committee, foreign_key: true
      t.references :user, foreign_key: true

      t.timestamps
    end
  end
end
