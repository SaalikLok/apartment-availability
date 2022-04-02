require "open-uri"
require "nokogiri"
require "pry"
require_relative "../preferences"

class Scraper
  attr_reader :results

  def initialize(apt_complex)
    @apt_complex = apt_complex
    @preferred_floorplans = PREFERENCES[apt_complex.to_sym]
    @results = {}
  end

  def scrape
    @preferred_floorplans.each do |plan|
      add_unit_to_result(plan)
    end
  end

  private

  def table(floorplan_id)
    site = Nokogiri.HTML5(URI.open("https://www.#{@apt_complex}.com/floorplans/#{floorplan_id}"))
    site.css("tbody").first
  end

  def add_unit_to_result(floorplan_id)
    if @apt_complex == "midtowncommons"
      scrape_midtown_rows(floorplan_id)
    elsif @apt_complex == "fivetwoapartments"
      scrape_fivetwo_rows(floorplan_id)
    else
      puts "Sorry, apartment complex not found."
    end
  end

  def unit(data_cells)
    if @apt_complex == "midtowncommons"
      return {
        number: data_cells.first.text.strip![-5..],
        rent: data_cells[2].text[6..10],
        date_available: data_cells[3].text.strip![5..]
      }
    elsif @apt_complex == "fivetwoapartments"
      return {
        number: data_cells[0].text.strip![4..],
        rent: data_cells[1].text.strip![5..],
        date_available: data_cells[3].text.strip![13..]
      }
    end
  end

  def scrape_midtown_rows(floorplan_id)
    table_body = table(floorplan_id)
    @results[floorplan_id.to_sym] = []

    table_body.css("tr").each do |row|
      data_cells = row.css("td")
      @results[floorplan_id.to_sym] << unit(data_cells)
    end
  end

  def scrape_fivetwo_rows(floorplan_id)
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
end