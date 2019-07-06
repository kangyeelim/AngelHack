class ScreenerController < ApplicationController
  def strategies
    # To be uncommented when strategy models created
    # @Strategies = Strategy.all
  end

  def companies
    strategy = params[:commit]
    strategy_type
    # Assign strategy type below
    if strategy == "Dividend"
      # Do dividend strategy
    elsif strategy == "Value"
      # Do value strategy
    end
    @company_pass_fail = []
    Company.all.each do |@company|
      @company_pass_fail << {company: @company, pass: screen_company(strategy_type)}
    end
  end

  def indicators
    # Need to get strategy type again
    # Need to get screen_company again
  end

  # Will perform each test differently / diff combination of test depending on strategy type
  def screen_company(strategy_type)
    price_to_earnings_test && current_ratio_test && debt_to_equity_test
  end

  def price_to_earnings_test
    @company.notifications.find_by(name: 'P/E Ratio') < 20
  end

  def current_ratio_test
    @company.notifications.find_by(name: 'Current Ratio') > 1.5
  end

  def debt_to_equity_test
    @company.notifications.find_by(name: 'D/E Ratio') < 0.35
  end
end
