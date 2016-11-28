class CompaniesController < ApplicationController
	def new
		@company = Company.new
	end

	def create
		@company = Company.new(params[:company])
		@company.save
		redirect_to new_company_team_path(@company.id)
	end

	def edit
		@company = Company.find(params[:id])
	end

	def update
	end

	def destroy
	end
end
