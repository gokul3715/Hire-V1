class RemoveRecruiterIdFromTeams < ActiveRecord::Migration
  def up
  	remove_column :teams, :recruiter_id
  end
end
