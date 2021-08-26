require "nokogiri"
require "csv"
require "yaml"

def fetch_unimarc_fieldlist_from_html(path)
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

def convert_rows_to_csv(rows, lang = nil)
  rows = format_rows rows
  result = rows.map { |row| row.to_csv }

  case lang
  when :en
    result.unshift(["Tag", "Label"].to_csv).join
  when :fr
    result.unshift(["Étiquette", "Description"].to_csv).join
  else
    result.join
  end
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

def generate_csv_file(path, output)
  File.open(path + ".csv", "w+") do |f|
    f.write output
  end
end

def generate_yaml_file(path, output)
  File.open(path + ".yml", "w+") do |f|
    f.write output
  end
end

require "pry"
Pry.start
