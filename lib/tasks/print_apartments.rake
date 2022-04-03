require_relative "../scraper"

desc "Send an email digest of available apartments"
task :print_apartments do
  midtown_commons = Scraper.new("midtowncommons")
  fivetwo = Scraper.new("fivetwoapartments")

  midtown_commons.print_table
  puts
  puts
  fivetwo.print_table
end
