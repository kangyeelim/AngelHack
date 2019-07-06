class StrategiesController < ApplicationController
	def index
		@strategies=["Dividend", "Value"]
	end

	def show
		@companies = [{:company => "Company 1", :result => "PASS"}, 
					{:company => "Company 2", :result => "FAIL"}]
	end
end
