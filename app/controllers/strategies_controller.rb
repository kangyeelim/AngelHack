class StrategiesController < ApplicationController
	def index
		@strategies = Strategy.all
	end

	def show
		@strategy = Strategy.find(params[:id])
	end
end
