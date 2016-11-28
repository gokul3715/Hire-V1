class RemoveColumnTeamFromCandidates < ActiveRecord::Migration
  def change
  	remove_column :candidates, :team
  end
end
