require_relative "./lib/scraper"

midtown_commons = Scraper.new("midtowncommons")
midtown_commons.scrape
puts midtown_commons.results

fivetwo = Scraper.new("fivetwoapartments")
fivetwo.scrape
puts fivetwo.results
