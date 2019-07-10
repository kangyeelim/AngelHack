namespace :db do
    desc "Populates strategy database"
    task :add_strategy_details => :environment do
        puts "Setting up test environment"
        puts "Destroying current records"
        Strategy.destroy_all

        puts "Adds new strategies"
        strategy_details = [{:name => "Dividend Investing", 
                            :explanation => "Dividend investing is where investors buy stocks and collect dividends, which are a portion of a company’s earnings distributed to the shareholders.", 
                            :indicators => ["Dividend yield", 
                                            "Earnings-per-share (EPS)", 
                                            "Price-to-earnings Ratio (P/E Ratio)", 
                                            "Pay-out Ratio", 
                                            "Total Return"
                                            ]
                            }, 
                            {:name => "Value Investing", 
                            :explanation => "Value investing is an investing strategy that involves picking stocks that appear to be trading for less than their intrinsic or book value then selling them for a price that is higher than their original cost.
", 

                            :indicators=>["Price-to-earnings Ratio (P/E Ratio) ", 
                                          "Earnings-per-share (EPS)", 
                                          "Current Ratio" , 
                                          "Acid Test (Quick Ratio)", 
                                          "Debt-to-Equity Ratio (D/E Ratio)"
                                          ]
                            }
                        ]
        strategy_details.each do |details|
            details[:indicators].each do |indicator|
            strategy = Strategy.create(:strategy_name => details[:name],
                                       :explanation => details[:explanation],
                                       :indicators => indicator);
            puts "Created strategy #{strategy.id} with name: #{strategy.strategy_name}, #{strategy.explanation} and #{strategy.indicators}"
            end
        end
    end
end