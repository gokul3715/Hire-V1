class RemoveRecruiterIdFromCandidates < ActiveRecord::Migration
  def change
  	remove_column :candidates, :recruiter_id
  end
end
