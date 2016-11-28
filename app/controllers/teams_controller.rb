class TeamsController < ApplicationController
	
	def new
		@company = Company.find(params[:company_id])
		@team = @company.teams.build
	end

	def create
		@company = Company.find(params[:company_id])
		@team = @company.teams.new(params[:team])
		@team.save
		redirect_to new_user_registration_path(:company_id => params[:company_id])
	end

	def edit
		@team = Team.find(params[:id])
	end

	def update
	end

	def destroy
	end
end
