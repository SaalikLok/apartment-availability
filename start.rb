require_relative "./lib/midtown_scraper"
require_relative "./lib/fivetwo_scraper"

puts "Hello World!"

# midtown_commons = MidtownScraper.new
# midtown_commons.scrape
# puts midtown_commons.results

fivetwo = FiveTwoScraper.new
fivetwo.scrape
puts fivetwo.results
