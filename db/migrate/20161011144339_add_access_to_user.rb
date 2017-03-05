class AddAccessToUser < ActiveRecord::Migration[5.0]
  def change
    add_column :users, :has_access, :boolean
  end
end
