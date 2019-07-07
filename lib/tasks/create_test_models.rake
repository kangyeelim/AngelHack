namespace :db do
    desc "Populates the database"
    task :set_test_environment => :environment do
        puts "Setting up test environment"
        puts "Destroying current records"
        Company.all.each do |company| company.destroy end
        Indicator.all.each do |indicator| indicator.destroy end
        puts "Creating Companies & Indicators"
        company_details = [
                        ["DBS", "D05.SI"],
                        ["Singtel", "Z74"],
                        ["Capitaland Mall Trust", "C38U"],
                        ["Capitaland Mall", "C38"],
                        ["OCBC", "O39"]]
        company_details.each do |details|
            company = Company.new
            company.name = details[0]
            company.ticker = details[1]
            company.save!
            for x in 0..2
                indicator_categories = ["P/E Ratio", "Current Ratio", "D/E Ratio"]
                indicator_details = [20, 1.5, 0.35]
                time = Time.now
                #indicator_details = [indicator_categories[x], [20, 1.5, 0.35], Time.now]
                indicator = Indicator.new
                indicator.category = indicator_categories[x]
                indicator.value = rand(0.0..50.0)
                indicator.last_updated = time
                indicator.company_id = company.id
                indicator.save!
            end
        end
        puts "Test environment settled with the following models created:"
        puts Company.all
        puts Indicator.all
    end
end