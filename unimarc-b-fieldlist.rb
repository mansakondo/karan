require "nokogiri"
require "csv"
require "yaml"

def fetch_unimarc_fieldlist_from_html(lang = :en)
  path = "unimarc-b-fieldlist-#{lang}.html"
  html = File.open(path) { |f| Nokogiri::HTML(f) }

  blocks = html.xpath "//div[@class='block']"
  rows = html.xpath "//div[@class='block']/following-sibling::div[not(@class = 'block')]"

  return blocks, rows
end

def format_rows(rows)
  result = []

  rows.each_slice(2) { |row| result << row.map(&:text) }

  result
end

def convert_rows_to_csv(rows)
  rows = format_rows rows
  rows.map { |row| row.to_csv }.join
end

def convert_rows_to_yaml(rows, lang = nil)
  rows = format_rows rows
  hash = {}

  if lang
    hash[lang.to_sym] = rows.to_h
  else
    hash = rows.to_h
  end

  hash.to_yaml
end

require "pry"
Pry.start
