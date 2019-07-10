class StrategiesController < ApplicationController
	def index
		@strategies=[{:name => "Dividend Investing", :explanation => "Dividend investing is where investors buy stocks and collect dividends, which are a portion of a company’s earnings distributed to the shareholders.", :indicators => ["Dividend yield", "Earnings-per-share (EPS)", "Price-to-earnings Ratio (P/E Ratio)", "Pay-out Ratio", "Total Return"]}, 
					{:name => "Value Investing", :explanation => "Value investing is an investing strategy that involves picking stocks that appear to be trading for less than their intrinsic or book value then selling them for a price that is higher than their original cost.
", :indicators=>["Price-to-earnings Ratio(P/E Ratio)", "Earnings-per-share (EPS)", "Current Ratio" , "Acid Test (Quick Ratio)", "Debt-to-Equity Ratio (D/E Ratio)"]}]
		
	end

	def show
	end
end
