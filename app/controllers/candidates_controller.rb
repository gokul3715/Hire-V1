class CandidatesController < ApplicationController
  include ApplicationHelper

  def index
  end

  def new
	@team = Team.find(params[:teamname])
	@candidate = @team.candidates.new
  end

  def create
	@candidate = Candidate.new(params[:candidate])

	if params[:candidate][:resume]

	  # Construct file name
	  file_name = params[:candidate][:resume].original_filename
	  email = params[:candidate][:email_].tr('@','')

	  # Construct path to save the file
	  dir_path = Rails.public_path + '/' + 'resumes/'+ email + '_'+ file_name
	  Dir.mkdir(dir_path)
	  path = File.join(dir_path,file_name)

	  # Store the file in filesystem & save the path in db
	  File.open(path, "wb") { |f| f.write(params[:candidate][:resume].read) }
	  @candidate.resume = path
	end

    if @candidate.save
      flash[:notice]="Candidate info added successfully!"
      redirect_to "/index"
    else
      redirect_to new_candidate_path
    end
  end

  def edit
	@candidate = Candidate.find(params[:id])
	@team = Team.find(@candidate.team_id)
  end

  def update
	@candidate = current_user.candidates.find(params[:id])
	@candidate.update_attributes(params[:candidate])
	redirect_to show_all_candidates_path
  end

  def show_all
	@company = current_user.team.company
	@candidate_info = @company.candidates
	get_candidate_interview_status(@candidate_info)
  end

  def show
	@candidate = Candidate.find(params[:id])
	@team = @candidate.team_id
	@invw = Interview.where("candidate_id=?",@candidate.id)

	@rounds = getRounds(@candidate.role)

	# List of completed rounds
	@completed_rounds = Array[]
	@vote = Array[]
		
	@invw.each do |x| 
	@completed_rounds.push(x.round)

	  if x.vote.nil?
		@nil_vote = "yes"
	  else
		@vote.push(x.vote)
	  end
  	end

    # Compare and calculate remaining rounds 
	@remaining_rounds =  @rounds - @completed_rounds

	if @remaining_rounds.empty?
	  @final_result = "Selected"
	  @vote.each do |k|
		if k != "Selected"
		  @final_result = "Rejected"
		  break
		end
	  end
	end

	respond_to do |format|
        format.html
        format.csv { send_file(@candidate.resume) }
        format.xml { render text: @candidate_info.to_xml}
    end		
  end

  def show_by_team
    # Get list of candidates based on teams
    @team = Team.find(current_user.team_id)
    @candidate_info = @team.candidates
    get_candidate_interview_status(@candidate_info)
    @candidate = @candidate_info.paginate(page: params[:page], per_page: 5)
  end

  def destroy
	@candidate = Candidate.find(params[:id])
	Candidate.find(params[:id]).destroy
	Interview.destroy_all(:candidate_id => params[:id])
	redirect_to show_all_candidates_path
  end

private

  def get_candidate_interview_status(candidate_info)
 	@new_entry = Array[]
	@on_the_go = Array[]
	@completed = Array[]

	@candidate_info.each do |x|
	  puts x.interviews
	  @invw = x.interviews

		if @invw.empty?
		  # Collecting all the new entries
		  @new_entry.push(x)
		else
		  @rounds = getRounds(x.role)
		  @round_count = @rounds.count
		  @completed_count=0
		  @invw.each do |y|
		  	if not y.vote.nil?
		  	  @completed_count = @completed_count + 1
		  	end
		  end

		  if @completed_count == @round_count
		  	@completed.push(x)
		  else
		  	@on_the_go.push(x)
		  end
		end
	end

	@new_entry = @new_entry.paginate(page: params[:new_entry], per_page: 5)
	@on_the_go = @on_the_go.paginate(page: params[:on_the_go], per_page: 5)
	@completed = @completed.paginate(page: params[:completed], per_page: 5)

	@candidate = @candidate_info.paginate(page: params[:page], per_page: 5)
  end
end