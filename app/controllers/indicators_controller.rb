class IndicatorsController < ApplicationController
	 def index
	 	@indicators = Indicator.all
	 end

	 def show 
	 end
end
