class ScreenerController < ApplicationController
  def strategies
    @count = 0
	  @strategies = [
	    {:name => "Dividend Investing", :explanation => "Dividend investing is where investors buy stocks and collect dividends, which are a portion of a company’s earnings distributed to the shareholders."}, 
	    {:name => "Value Investing", :explanation => "Value investing is an investing strategy that involves picking stocks that appear to be trading for less than their intrinsic or book value then selling them for a price that is higher than their original cost."}]
    # To be uncommented when strategy models created
    # @Strategies = Strategy.all
  end

  def companies
    strategy = params[:strategy_id].to_i
    @strategy_info = ["Dividend Investing", "Value Investing"][strategy]
    @company_pass_fail = []
    Company.all.each do |company|
      @company_pass_fail << {company: company, pass: screen_company(strategy, company)}
    end
  end

  def indicators
    @thresholds = {"P/E Ratio" => "< 20", "Current Ratio" => "> 1.5", "D/E Ratio" => "< 0.35"}
    strategy = params[:strategy_id].to_i
    @company = Company.find(params[:company_id])
    @indicators_pass_fail = []
    @company.indicators.all.each do |indicator|
      if strategy == 0
        @indicators_pass_fail << {name: indicator.category,
          pass: (case indicator.category
            when 'P/E Ratio'
              price_to_earnings_indicator_test(indicator)
            end
          )}
      elsif strategy == 2 || strategy == 1
        @indicators_pass_fail << {name: indicator.category,
          pass: (case indicator.category
            when 'P/E Ratio'
              price_to_earnings_indicator_test(indicator)
            when 'Current Ratio'
              current_ratio_indicator_test(indicator)
            when 'D/E Ratio'
              debt_to_equity_indicator_test(indicator)
            end
          )}
      end
    end
  end

  # Will perform each test differently / diff combination of test depending on strategy type
  def screen_company(strategy, company)
    if strategy == 0
      price_to_earnings_company_test(company) 
    elsif strategy == 2 || strategy == 1
      price_to_earnings_company_test(company) && current_ratio_company_test(company) && debt_to_equity_company_test(company)
    end
  end

  def price_to_earnings_company_test(company)
    company.indicators.find_by(category: 'P/E Ratio').value < 20
  end

  def price_to_earnings_indicator_test(indicator)
    indicator.value < 20
  end

  def current_ratio_company_test(company)
    company.indicators.find_by(category: 'Current Ratio').value > 1.5
  end

  def current_ratio_indicator_test(indicator)
    indicator.value > 1.5
  end

  def debt_to_equity_company_test(company)
    company.indicators.find_by(category: 'D/E Ratio').value < 0.35
  end

  def debt_to_equity_indicator_test(indicator)
    indicator.value < 0.35
  end
end
