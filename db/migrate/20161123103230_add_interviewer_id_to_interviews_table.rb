class AddInterviewerIdToInterviewsTable < ActiveRecord::Migration
  def change
  	add_column :interviews, :interviewer_id, :integer
  end
end
