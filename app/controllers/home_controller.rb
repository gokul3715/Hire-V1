class HomeController < ApplicationController
  #before_filter :authenticate_user!
  
  def index
    case current_user.role.downcase
  	  when "recruiter"
        # Redirects to HR View
  	    redirect_to  home_hr_path

      when "developer"
        # Redirects to Team Member View
  		  redirect_to  home_member_path

  	  when "manager"
        # Redirects to Manager View
  		  redirect_to  home_manager_path

      when "tester"
        # Redirects to Team Member view
        redirect_to home_member_path
  	end
  end

  def index_hr
    # Action shows the HR view
    @team = Team.find(current_user.team_id)
    @company = @team.company
  end

  def index_manager

    # Get list of candidates based on user email (either manager/team member)
    get_pending_completed_data
  end

  def index_member

    # Get list of candidates based on user email (either manager/team member)
    get_pending_completed_data
  end

  def interview_corner
  end

  def get_team
    @company = current_user.team.company
    @team = @company.teams
  end

  def send_invite
    @recruiter = current_user.username
    @recipients = params[:emaillist]
    @team = params[:team_id]

    SendMail.delay.invite_mail(@recruiter, @recipients, @team)
    redirect_to home_hr_path
  end

  def home_page

  end

  def get_company

  end

  def select_team
    @company = current_user.team.company
    @team = @company.teams
  end

  private 

  def get_pending_completed_data
    #@pending_interview = Interview.where("interviewer=? and vote IS ?",current_user.email,nil)
    @pending_interview = current_user.scheduled_to.where("VOTE IS ?",nil)
    @pending_interview = @pending_interview.paginate(page: params[:page1], per_page: 5)
    #@completed_interview = Interview.where("interviewer=? and vote IS NOT ?",current_user.email,nil)
    @completed_interview = current_user.scheduled_to.where("VOTE IS NOT ?",nil)
    @completed_interview = @completed_interview.paginate(page: params[:page2], per_page: 5)
  end

end
