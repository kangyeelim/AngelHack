namespace :scraper do
    desc "Scrapes Yahoo Finance and SGX for stock data"
    task update_indicators: :environment do



        def update_indicators
            Companies.all.each do |@company|
                @base_url = "https://sg.finance.yahoo.com/quote/#{@company.ticker}"
                @statistics_page = "#{@base_url}/key-statistics?p=#{@company.ticker}"
                @analysis_page = "#{@base_url}/analysis?p=#{@company.ticker}"
                
                # Scrape for the following
                price_to_equity
                current_ratio
                debt_to_equity
            end
        end

        def get_data(company)
            # Do we need some sort of master url? Maybe trading code?
            # company.name and company.ticker ?

            url = "https://sg.finance.yahoo.com/screener/new"
            browser = Watir::Browser.new(:chrome)
            browser
            #by right above we need something to go and filter to sg companies since the below link works only for a few days
            yh_url = "https://sg.finance.yahoo.com/screener/unsaved/e2a085df-9287-42f1-8c81-7f04a6bb3d5f"
        
            page = Nokogiri::HTML(open(yh_url))
            #scraping companies in their table but somehow it doesnt just do one page but also doesnt scrape all
            all_rows = page.css("div table tbody tr")
            Company.destroy_all
            all_rows.each do |row|
                cell = row.css("td")
                comp = Company.find_or_create_by(name: cell[1].text)
                comp.update_attribute(:ticker, cell[0].text)
                #here is supposed to update their indicators to link i guess
            end
            # Below are the things that need to be scraped
            # 1) Price to Earnings (P/E) Ratio => SGX
            #    - P/E Ratio = Market Value Per Share / Earnings Per Share
            #    - https://sg.finance.yahoo.com/quote/#{ticker}/key-statistics?p=#{ticker}
            # 2) Earnings Per Share (EPS) => Yahoo Finance
            #    - Usually listed in fundamentals section
            #    - https://sg.finance.yahoo.com/quote/#{ticker}/analysis?p=#{ticker}
            # 3) Current Ratio AKA Working Capital Ratio => Yahoo Finance
            #    - Current Ratio = Current Assets / Current Liabilities
            #    - https://sg.finance.yahoo.com/quote/#{ticker}/key-statistics?p=#{ticker}
            # 4) Acid Test Ratio = ???
            # 5) Debt to Equity (D/E) Ratio => Yahoo Finance
            #    - D/E = Total Liabilities = Total Shareholders' Equity
            #    - https://sg.finance.yahoo.com/quote/#{ticker}/key-statistics?p=#{ticker}

        end

        def price_to_equity
            indicator = @company.indicators.find_by(name: 'P/E Ratio')
        end

        def earnings_per_share
            # On hold, EPS cannot be used by itself
        end

        def current_ratio
            indicator = @company.indicators.find_by(name: 'Current Ratio')
        end

        def acid_test_ratio
            # ???
        end

        def debt_to_equity
            indicator = @company.indicators.find_by(name: 'D/E Ratio')
        end

        # Opens urls
        def data_scraper(url)
            Nokogiri::HTML(open(url))
        end

        
    end
end

# Test coy: DBS D05.SI