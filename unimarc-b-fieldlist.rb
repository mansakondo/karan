require "nokogiri"
require "csv"

def fetch_unimarc_fieldlist_from_html(lang = :en)
  path = "unimarc-b-fieldlist-#{lang}.html"
  html = File.open(path) { |f| Nokogiri::HTML(f) }

  blocks = html.xpath "//div[@class='block']"
  fields = html.xpath "//div[@class='block']/following-sibling::div[not(@class = 'block')]"

  return blocks, fields
end

def convert_rows_to_csv(rows)
  rows.map { |row| row.to_a.to_csv }.join
end

require "pry"
Pry.start
