class RemoveColumnInterviewerMail < ActiveRecord::Migration
  def change
  	remove_column :interviews, :interviewer
  end
end
