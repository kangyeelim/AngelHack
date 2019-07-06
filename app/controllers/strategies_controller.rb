class StrategiesController < ApplicationController
	def index
		@strategies=[{:name => "Dividend Investing", :explanation => "Looks at how much dividends a stock gives."}, 
					{:name => "Value Investing", :explanation => "Looks at intrinsic value of stock."}]
	end

	def show
	end
end
