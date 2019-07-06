# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
indicators = [["Price to Earnings Ratio (P/E)", 
			  "Measures current share price relative to its per-share earnings.",
			  "P/E = Market value per share / Earnings per share"]]

indicators.each do |name, explanation, function|
	Indicator.create(name: name, explanation: explanation, function: function)
end