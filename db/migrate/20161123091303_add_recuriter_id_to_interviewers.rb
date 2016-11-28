class AddRecuriterIdToInterviewers < ActiveRecord::Migration
      def change
    add_column :interviewers, :recruiter_id, :integer
  end
end
