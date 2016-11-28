class AddSignedUpTeamIdToUsers < ActiveRecord::Migration
def change
  	add_column :users, :signed_up, :boolean
  	add_column :users, :team_id, :integer
  end
end
