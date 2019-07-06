class IndicatorsController < ApplicationController
	 def index
	 	@indicators = Indicator.all
	 end

	 def show 
	 	@indicator = Indicator.params([:id])
	 end
end
