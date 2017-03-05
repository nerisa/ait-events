class CreateEvents < ActiveRecord::Migration[5.0]
  def change
    create_table :events do |t|
      t.string :name
      t.text :description
      t.string :venue
      t.date :start_date
      t.date :end_date
      t.references :committee, foreign_key: true

      t.timestamps
    end
  end
end
