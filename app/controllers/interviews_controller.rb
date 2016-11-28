class InterviewsController < ApplicationController
	include ApplicationHelper

	def index
	end

	def new
	  	@candidate = Candidate.find(params[:candidate_id])
		#@invw_info = Interview.where("candidate_id=?",params[:candidate_id])
		@invw_info = @candidate.interviews

		# List of interviews
		#@rounds=["PS & Coding","Algorithm","Designing","Manager discussion","HR discussion"]
		@rounds = getRounds(@candidate.role)
		puts @rounds

		# List of completed rounds
		@completed_rounds = Array[]
		
		@invw_info.each do |x| 
			@completed_rounds.push(x.round)
			puts x.round
		end

		# Compare and calculate remaining rounds 
		@remaining_rounds =  @rounds - @completed_rounds
		
		# Get interviewer's list
		#@users = User.where("team_name=?",@candidate.team)
		@team = Team.find(@candidate.team_id)
		@get_team_members = @team.users

		#@interviewer_list = Array[]
		#@get_interviewers.each do |x|
		#	@interviewer_list.push(x.email)
		#end

		@HR_team = Team.find(current_user.team_id)
		@get_HRs = @HR_team.users

		@get_interviewers = @get_team_members + @get_HRs
		#@users.each do |x|
		#	@interviewer_list.push(x.email)
		#end		

		@interview = @candidate.interviews.build 

	end

	def create
		candidate = Candidate.find(params[:candidate_id])
		@interview = candidate.interviews.new( params[:interview].merge({:recruiter_id => current_user.id}))
		#@interview = candidate.interviews.new( params[:interview])
		@candidate_name = candidate.name
		@recruiter=current_user.username
		@user_record = User.find(params[:interview][:interviewer_id])
		
		SendMail.delay.schedule_interview(@user_record.email,@user_record.username, @interview.round, @interview.scheduled_at, @candidate_name, @recruiter)

    	a =  @interview.scheduled_at.strftime("%F %H:%M:%S")
    	# Time.parse(a)
    	a += " +0530"
    	# Time.parse(a)
		b = Time.now

		remaining = ( a.to_time - b.to_time )/60 
		remaining = remaining.to_i - 10
	
		SendMail.delay_until(remaining.minutes.from_now).reminder_mail(@user_record.email,@user_record.username, @interview.round, @interview.scheduled_at, @candidate_name, @recruiter)
		@interview.save
		flash[:success] = "Interview scheduled successfully!"
        redirect_to candidate_path(candidate)
	end

	def edit
		@candidate = Candidate.find(params[:candidate_id])
		@invw = Interview.find(params[:id])
		@interview = @candidate.interviews.build
	end

	def update
		@candidate = Candidate.find(params[:candidate_id])
		@interview = @candidate.interviews.find(params[:id])
		@interview.update_attributes(params[:interview])
		redirect_to index_path
	end

	def show
		@candidate = Candidate.find(params[:candidate_id])
		@invw = Interview.find(params[:id])
	end

end
