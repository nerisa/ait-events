class ChangeAnnouncementDescriptionToText < ActiveRecord::Migration[5.0]
  def change
    change_column :announcements, :description,  :text
  end
end
