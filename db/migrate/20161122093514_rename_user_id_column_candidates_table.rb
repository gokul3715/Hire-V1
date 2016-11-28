class RenameUserIdColumnCandidatesTable < ActiveRecord::Migration
  def change
 rename_column :candidates, :user_id, :recruiter_id
  end
end
