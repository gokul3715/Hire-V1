class CreateInterviews < ActiveRecord::Migration
  def change
    create_table :interviews do |t|
      t.integer :user_id
      t.integer :candidate_id
      t.string :round
      t.string :interviewer
      t.datetime :scheduled_at
      t.text :feedback
      t.string :vote

      t.timestamps
    end
  end
end
