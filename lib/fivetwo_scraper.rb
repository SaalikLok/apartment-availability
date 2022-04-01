require "open-uri"
require "nokogiri"
require "pry"
require_relative "../preferences"

class FiveTwoScraper
  attr_reader :results

  def initialize
    @preferred_floorplans = Preferences.fivetwo
    @results = {}
  end

  def scrape
    @preferred_floorplans.each do |plan|
      add_unit_to_result(plan)
    end
  end

  private

  def add_unit_to_result(floorplan_id)
    table_body = table(floorplan_id)
    @results[floorplan_id.to_sym] = []
    rows = table_body.css("tr") if table_body

    if rows
      rows[1..-2].each do |row|
        data_cells = row.css("td")
        @results[floorplan_id.to_sym] << unit(data_cells)
      end
    end
  end

  def unit(data_cells)
    {
      number: data_cells[0].text.strip![4..],
      rent: data_cells[1].text.strip![5..],
      date_available: data_cells[3].text.strip![13..]
    }
  end

  def table(floorplan_id)
    site = Nokogiri.HTML5(URI.open("https://www.fivetwoapartments.com/floorplans/#{floorplan_id}"))
    site.css("tbody").first
  end
end
