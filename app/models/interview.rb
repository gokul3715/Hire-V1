class Interview < ActiveRecord::Base
  attr_accessible :candidate_id, :feedback, :interviewer_id, :round, :scheduled_at, :recruiter_id, :vote
  belongs_to :candidate, dependent: :destroy
  belongs_to :recruiter, class_name: "User", :foreign_key => "recruiter_id"
  belongs_to :interviewer, class_name: "User", :foreign_key => "interviewer_id"
end
