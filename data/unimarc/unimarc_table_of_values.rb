require "nokogiri"
require "csv"

def fetch_unimarc_table_values_from_html
  path = "unimarc_table_of_values.html"
  html = File.open(path) { |f| Nokogiri::HTML(f) }

  elements = html.xpath "//div/div"

  table_starter = html.xpath("//div[normalize-space() = 'Field']").first
  page_ender = html.xpath("//div[normalize-space() = '2008']").first

  start_position = elements.index table_starter
  end_position = elements.index page_ender

  cells = elements[start_position...end_position]

  rows = []
  start = 0
  while start < end_position
    row = cells[start..(start + 5)]
    rows << row unless row.nil?
    start += 6
  end

  rows
end

def convert_rows_to_csv(rows)
  rows.map { |row| row.to_a.to_csv }.join
end

require "pry"
Pry.start
