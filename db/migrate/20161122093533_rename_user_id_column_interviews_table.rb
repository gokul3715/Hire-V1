class RenameUserIdColumnInterviewsTable < ActiveRecord::Migration
  def change
  	rename_column :interviews, :user_id, :recruiter_id
  end
end
