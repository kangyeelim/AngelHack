class ScreenersController < ApplicationController
	def index
		@strategies = Strategy.all
	end

	def show
		@strategy = Strategy.find(params[:id])
		@companies = @strategy.companies.order(...)
	end
end
