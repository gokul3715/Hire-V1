class SendMail < ActionMailer::Base
  default from: "spgokul@gmail.com"

  def schedule_interview(user_mail, interviewer_name, round, scheduled_at, candidate_name, recruiter)
    @user = user_mail
    @round = round
    @scheduled_at = scheduled_at
    @candidate_name = candidate_name
    @recruiter = recruiter
    @interviewer_name = interviewer_name
    mail(to: @user, subject:"Interview schedule for : "+ @round+" round")
  end

  def invite_mail(recruiter, recipients, team_id)
    @recruiter = recruiter
    @recipients = recipients
    @team = team_id
    mail(to: @recipients, subject:"Invite to use Hire Tool")
  end

  def reminder_mail(user_mail, interviewer_name, round, scheduled_at, candidate_name, recruiter)
    @user = user_mail
    @round = round
    @scheduled_at = scheduled_at
    @candidate_name = candidate_name
    @recruiter = recruiter
    @interviewer_name = interviewer_name
    mail(to: @user, subject:"Reminder: Interview schedule for : "+ @round+" round")
  end
end
