class ChangeInterviewerIdToEmail < ActiveRecord::Migration
  def up
  	change_column :interviews, :interviewer, :string
  end

  def down
  	change_column :interviews, :interviewer, :integer
  end
end
