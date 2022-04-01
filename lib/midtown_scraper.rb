require "open-uri"
require "nokogiri"
require "pry"
require_relative "../preferences"

class MidtownScraper
  attr_reader :results

  def initialize
    @preferred_floorplans = Preferences.midtown
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

    table_body.css("tr").each do |row|
      data_cells = row.css("td")
      @results[floorplan_id.to_sym] << unit(data_cells)
    end
  end

  def unit(data_cells)
    {
      number: data_cells.first.text.strip![-5..],
      rent: data_cells[2].text[6..10],
      date_available: data_cells[3].text.strip![5..]
    }
  end

  def table(floorplan_id)
    site = Nokogiri.HTML5(URI.open("https://www.midtowncommons.com/floorplans/#{floorplan_id}"))
    site.css("tbody").first
  end
end
