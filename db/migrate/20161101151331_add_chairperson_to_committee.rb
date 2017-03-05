class AddChairpersonToCommittee < ActiveRecord::Migration[5.0]
  def change
    add_reference :committees, :user, foreign_key: true
  end
end
