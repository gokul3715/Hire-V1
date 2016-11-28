class ChangeResumeFormatInCandidate < ActiveRecord::Migration
  def up
  	change_column :candidates, :resume, :string
  end

  def down
  	change_column :candidates, :resume, :binary
  end
end
