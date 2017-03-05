class AddRolesToUser < ActiveRecord::Migration[5.0]
  def change
    add_column :users, :is_super_admin, :boolean
    add_column :users, :is_master_admin, :boolean
    add_column :users, :is_member, :boolean
  end
end
