require "open-uri"
require "nokogiri"
require "pry"

floorplans_we_like = ['b3', 'a3']

site = Nokogiri.HTML5(URI.open('https://www.midtowncommons.com/floorplans/b3'))
table_body = site.css('tbody').first

floorplans = {
  b3: {
    units: []
  }
}

table_body.css('tr').each do |row|
  data_cells = row.css('td')

  unit = {
    number: data_cells.first.text.strip![-5..],
    sqft: data_cells[1].text[8..],
    rent: data_cells[2].text[6..10],
    date_available: data_cells[3].text.strip![5..]
  }

  floorplans[:b3][:units] << unit
end

floorplans.each do |floorplan|
  puts floorplan
end
