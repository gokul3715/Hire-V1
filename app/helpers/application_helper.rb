module ApplicationHelper

	# Method to list interview rounds based on roles
	def getRounds(role)
		if role.eql? "Product Developer"
			@rounds = ["PS & Coding","Designing","Algorithm","Manager Discussion","HR Discussion"]
		elsif role.eql? "SDET"
			@rounds = ["PS & Coding","Automation Design","Testing Techniques","Manager discussion","HR Discussion"]
		elsif role == "Designer"
			@rounds = ["Design Analysis","Desinging Concepts", "Manager Discussion", "HR Discussion"]
		elsif role == "Sales Engineer"
			@rounds = ["Marketing strategy", "Business understanding", "Manager Discussion","HR Discussion"]
		elsif role == "Pre-Sales"
			@rounds = ["Marketing strategy", "Business understanding", "Manager Discussion","HR Discussion"]
		else
			@rounds = ["PS & Coding","Designing","Algorithm","Manager Discussion","HR Discussion"]
		end				
	end

	def getTeamName(team_id)
		@team = Team.find(team_id)
		@team.name
	end

	def getInterviewerName(id)
		@user = User.find(id)
		@user.username
	end

	def getInterviewerEmail(id)
		@user = User.find(id)
		@user.email 
	end
end
