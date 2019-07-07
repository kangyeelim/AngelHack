class StrategiesController < ApplicationController
	def index
		@strategies=[{:name => "Dividend Investing", :explanation => "Dividend investing is where investors buy stocks and collect dividends, which are a portion of a company’s earnings distributed to the shareholders."}, 
					{:name => "Value Investing", :explanation => "Value investing is an investing strategy that involves picking stocks that appear to be trading for less than their intrinsic or book value then selling them for a price that is higher than their original cost.
"}]
	end

	def show
	end
end
