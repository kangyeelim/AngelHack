class StrategiesController < ApplicationController
	def index
		@strategies=["Dividend", "Value"]
	end

	def show
		@companies = ["Company 1", "Company 2"]
	end
end
