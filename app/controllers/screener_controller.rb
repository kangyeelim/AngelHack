class ScreenerController < ApplicationController
  def strategies
    @strategies=["Dividend", "Value"]
    # To be uncommented when strategy models created
    # @Strategies = Strategy.all
  end

  def companies
    strategy = params[:commit]
    byebug
    @strategy_shown_on_screen = params[:commit]
    #strategy_type
    @strategy_info = ["Dividend", "Value"] #temporary fix, to be uncommented when strategy models created
    @company_pass_fail = []
    Company.all.each do |company|
      @company_pass_fail << {company: company, pass: screen_company(strategy, company)}
    end
  end

  def indicators
    # Need to get strategy type again
    # Need to get screen_company again
  end

  # Will perform each test differently / diff combination of test depending on strategy type
  def screen_company(strategy, company)
    price_to_earnings_test(company) && current_ratio_test(company) && debt_to_equity_test(company)
  end

  def price_to_earnings_test(company)
    company.indicators.find_by(category: 'P/E Ratio').value < 20
  end

  def current_ratio_test(company)
    company.indicators.find_by(category: 'Current Ratio').value > 1.5
  end

  def debt_to_equity_test(company)
    company.indicators.find_by(category: 'D/E Ratio').value < 0.35
  end
end
