class RenameTeamColumnNameInUserTable < ActiveRecord::Migration
  def change
  	rename_column :users, :team, :team_name
  end
end
