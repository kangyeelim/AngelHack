namespace :web_scrape do
    desc "Scrapes Yahoo Finance and SGX for stock data"
    task scrape: :environment do

        def update_indicators
            Companies.all.each do |company|
                # Scrape & obtain info
                # 
            end
        end

        def get_data(company)
            # Do we need some sort of master url? Maybe trading code?
            # company.name and company.ticker ?


            # Below are the things that need to be scraped
            # 1) Price to Earnings (P/E) Ratio => SGX
            #    - P/E Ratio = Market Value Per Share / Earnings Per Share
            #    - https://www2.sgx.com/securities/stock-screener (need to key in coy name only)
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
        end

        def earnings_per_share
        end

        def current_ratio
        end

        def acid_test_ratio
        end

        def debt_to_equity
        end

        # Opens urls
        def data_scraper(url)
            Nokogiri::HTML(open(url))
        end
    end
end

# Test coy: DBS D05.SI