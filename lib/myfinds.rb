require 'rubygems'
require 'nokogiri'
require 'date'

class MyFindsStatisticsGenerator
  def initialize
  end
  
  def generate
    prepare_session
    login
    grab_data
    generate_statistics
  end
  
  def prepare_session
  end
  
  def login
  end
  
  def grab_data
    @html = IO.read 'myfinds.html'
    document = Nokogiri::HTML.parse @html
    @engine = StatisticsEngine.new
    @engine.add_handler Counter.new
    @engine.add_handler TopTen.new :date, 25
    @engine.add_handler TopTen.new :region, 25
    @engine.add_handler TopTen.new :country, 10
    @engine.add_handler TopTenMonths.new
    @engine.add_handler TopTenWeeks.new
    @engine.add_handler TopTenWeekDays.new
    @engine.add_handler Suite.new 2
    @engine.add_handler Suite.new 3
    @engine.add_handler Suite.new 4
    @engine.add_handler Suite.new 5
    @engine.add_handler Suite.new 6
    @engine.add_handler Suite.new 7
    @engine.add_handler Suite.new 8
    @engine.add_handler Suite.new 9
    @engine.add_handler Suite.new 10
    @engine.add_handler Suite.new 20
    @engine.add_handler Suite.new 30
    @engine.add_handler Suite.new 60
    @engine.add_handler Suite.new 100
    @engine.add_handler Suite.new 200
    @engine.add_handler Suite.new 365
    document.xpath( '//table[@class="Table"]/tbody/tr' ).each do |row|
      cells = row.search 'td'
      cache = {}
      cache[:date] = date_from cells
      cache[:name] = name_from cells
      cache[:region], cache[:country] = location_from cells
      @engine.add cache
    end
  end
  
  def generate_statistics
    puts @engine.report
  end
  
  :private
  def date_from cells
    american_date = cells[2].inner_text
    parts = american_date.split '/'
    Date.new parts[2].to_i, parts[0].to_i, parts[1].to_i
  end
  
  def name_from cells
    name_cell = cells[3]
    name_cell.search( 'a' )[1].inner_text
  end
  
  def location_from cells
    location = cells[4].inner_text
    parts = location.split ','
    if parts.size == 2
      region = parts[0].strip
      country = parts[1].strip.split( "\r" )[0]
    else
      region = ''
      country = parts[0].strip.split( "\r" )[0]
    end
    region = country if region.empty?
    [region, country]
  end
end

