class RenameUserIdColumnTeamsTable < ActiveRecord::Migration
  def change
  	rename_column :teams, :user_id, :recruiter_id
  end
end
