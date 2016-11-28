class DropTableInterviewer < ActiveRecord::Migration
  def change
  	drop_table :interviewers
  end
end
