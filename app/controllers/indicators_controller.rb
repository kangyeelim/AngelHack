class IndicatorsController < ApplicationController
	 def index
	 	@indicators = Indicator.all
	 end

	 def show 
	 	@indicator = Indicator.find(params[:id])
	 end
end
