namespace :db do
  desc "Populates the database"
  task :set_test_environment => :environment do
    puts "Setting up test environment"
    puts "Destroying current records"
    Company.destroy_all
    Indicator.destroy_all
    puts "Creating Companies & Indicators"
    company_details = [["DBS", "D05.SI"],
                       ["Singtel", "Z74"],
                       ["Capitaland Mall Trust", "C38U"],
                       ["Capitaland Mall", "C38"],
                       ["OCBC", "O39"]]
    indicator_categories = ["P/E Ratio", "Current Ratio", "D/E Ratio"]
    indicator_details = [20, 1.5, 0.35]
    company_details.each do |details|
      company = Company.create(:name => details[0], :ticker => details[1])
      for x in 0..2
        indicator = company.indicators.create(:category => indicator_categories[x], :value => rand(0.0..50.0), :last_updated => Time.now)
      end
    end
    puts "Test environment settled with #{Company.all.length} Companies and #{Indicator.all.length} Indicators created"
  end
end