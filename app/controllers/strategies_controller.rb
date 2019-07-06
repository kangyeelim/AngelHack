class StrategiesController < ApplicationController
	def index
		@strategies=["Dividend", "Value"]
	end

	def show
		@result = @strategies[index]
	end
end
