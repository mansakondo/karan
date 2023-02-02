Catalog::MARC::Record.create leader: "00815nam 2200289 a 4500", fields: [
  { "tag": "001", "value": "ocm30152659" },
  { "tag": "003", "value": "OCoLC" },
  { "tag": "005", "value": "19971028235910.0" },
  { "tag": "008", "value": "940909t19941994ilua 000 0 eng " },
  { "tag": "010", "indicator1": " ", "indicator2": " ", "subfields": [{ "code": "a", "value": "92060871" }] },
  { "tag": "020", "indicator1": " ", "indicator2": " ", "subfields": [{ "code": "a", "value": "0844257443" }] },
  { "tag": "040", "indicator1": " ", "indicator2": " ", "subfields": [{ "code": "a", "value": "DLC" }, { "code": "c", "value": "DLC" }, { "code": "d", "value": "BKL" }, { "code": "d", "value": "UtOrBLW" } ] },
  { "tag": "049", "indicator1": " ", "indicator2": " ", "subfields": [{ "code": "a", "value": "BKLA" }] },
  { "tag": "099", "indicator1": " ", "indicator2": " ", "subfields": [{ "code": "a", "value": "822.33" }, { "code": "a", "value": "S52" }, { "code": "a", "value": "S7" } ] },
  { "tag": "100", "indicator1": "1", "indicator2": " ", "subfields": [{ "code": "a", "value": "Shakespeare, William," }, { "code": "d", "value": "1564-1616." } ] },
  { "tag": "245", "indicator1": "1", "indicator2": "0", "subfields": [{ "code": "a", "value": "Hamlet" }, { "code": "c", "value": "William Shakespeare." } ] },
  { "tag": "264", "indicator1": " ", "indicator2": "1", "subfields": [{ "code": "a", "value": "Lincolnwood, Ill. :" }, { "code": "b", "value": "NTC Pub. Group," }, { "code": "c", "value": "[1994]" } ] },
  { "tag": "264", "indicator1": " ", "indicator2": "4", "subfields": [{ "code": "c", "value": "©1994." }] },
  { "tag": "300", "indicator1": " ", "indicator2": " ", "subfields": [{ "code": "a", "value": "xiii, 295 pages :" }, { "code": "b", "value": "illustrations ;" }, { "code": "c", "value": "23 cm." } ] },
  { "tag": "336", "indicator1": " ", "indicator2": " ", "subfields": [{ "code": "a", "value": "text" }, { "code": "b", "value": "txt" }, { "code": "2", "value": "rdacontent." } ] },
  { "tag": "337", "indicator1": " ", "indicator2": " ", "subfields": [{ "code": "a", "value": "unmediated" }, { "code": "b", "value": "n" }, { "code": "2", "value": "rdamedia." } ] },
  { "tag": "338", "indicator1": " ", "indicator2": " ", "subfields": [{ "code": "a", "value": "volume" }, { "code": "b", "value": "nc" }, { "code": "2", "value": "rdacarrier." } ] },
  { "tag": "490", "indicator1": "1", "indicator2": " ", "subfields": [{ "code": "a", "value": "NTC Shakespeare series." }] },
  { "tag": "830", "indicator1": " ", "indicator2": "0", "subfields": [{ "code": "a", "value": "NTC Shakespeare series." }] },
  { "tag": "907", "indicator1": " ", "indicator2": " ", "subfields": [{ "code": "a", "value": ".b108930609" }] },
  { "tag": "948", "indicator1": " ", "indicator2": " ", "subfields": [{ "code": "a", "value": "LTI 2018-07-09" }] },
  { "tag": "948", "indicator1": " ", "indicator2": " ", "subfields": [{ "code": "a", "value": "MARS" }] }
], format: "marc21", marc_recordable: Catalog::MARC::Record::BibliographicRecord.new

batch_size = 1000

progress_callback = -> (rows_size, num_batches, current_batch_number, batch_duration_in_secs) {
  last_batch = current_batch_number == num_batches
  remainder  = rows_size.remainder(batch_size)

  inserted = if last_batch && remainder > 0
    batch_size * (current_batch_number - 1) + remainder
  else
    batch_size * current_batch_number
  end

  left = rows_size - inserted

  puts "Batches inserted: #{current_batch_number}"
  puts "Records inserted: #{inserted}"
  puts

  puts "Batches left: #{num_batches - current_batch_number}"
  puts "Records left: #{left}"
  puts
}

puts

# total_time = Benchmark.measure do
#   records = []
#
#   require "zoom"
#
#   bib_record_class = Catalog::MARC::Record::BibliographicRecord
#
#   isbn_list = %w( 9780307463746 9780578012810 9780804137508 9780132852098 9780134757599 9781941222126 0974514055 9781937785536)
#   isbn_list.each do |isbn|
#     conn = ZOOM::Connection.new.connect("symphony.torontopubliclibrary.ca:2200")
#     conn.database_name = "unicorn"
#     conn.lang = "en"
#     conn.preferred_record_syntax = "MARC21"
#
#
#     results = conn.search "@attr 1=7 #{isbn}"
#     marc    = results[0].raw
#     record  = Catalog::MARC::Record.new_from_marc(marc)
#
#     marc_recordable        = bib_record_class.new
#     record.format          = "marc21"
#     record.marc_recordable = marc_recordable
#
#     records << marc_recordable
#   end
#
#
#   total = nil
#
#   time = Benchmark.measure do
#     result = bib_record_class.bulk_import(
#       records,
#       batch_size: batch_size,
#       batch_progress: progress_callback,
#       recursive: true
#     )
#
#     num_records = records.size
#
#     total = num_records - result.failed_instances.count
#   end
#
#   puts "#{total} records imported in #{time.real} seconds"
# end
#
# puts "Total time (in secs): #{total_time.real}"
# puts

marc21_glob   = Rails.root.join("data", "marc_toronto_public_library", "{OL, DATA}.*")
marc21_files  = Dir[marc21_glob]
marc21_file   = marc21_files.first

total_time = Benchmark.measure do
  puts "Decoding MARC21 records..."
  puts

  marc21_records, record_type_class = Catalog::MARC::Record.read(marc21_file, format: :marc21, autosave: true)

  num_records = marc21_records.count

  puts "Importing #{num_records} MARC21 records..."
  puts

  total = nil

  time = Benchmark.measure do
    result = record_type_class.bulk_import(
      marc21_records.to_a.take(100),
      batch_size: batch_size,
      batch_progress: progress_callback,
      recursive: true
    )

    total = num_records - result.failed_instances.count
  end

  puts "#{total} records imported in #{time.real} seconds"
end

puts "Total time (in secs): #{total_time.real}"
puts

# unimarc_bib_glob   = Rails.root.join("data", "unimarc", "records", "bib", "*")
# unimarc_auth_glob  = Rails.root.join("data", "unimarc", "records", "auth", "*")
# unimarc_bib_files  = Dir[unimarc_bib_glob]
# unimarc_auth_files = Dir[unimarc_auth_glob]
#
# total_time = Benchmark.measure do
#   puts "Decoding UNIMARC records..."
#   puts
#
#   unimarc_bib_files.each do |unimarc_file|
#     total = nil
#
#     time = Benchmark.measure do
#       unimarc_records, record_type_class = Catalog::MARC::Record.read(unimarc_file, format: "unimarc", autosave: true)
#       num_records     = unimarc_records.count
#
#       puts "Importing #{num_records} UNIMARC bibliographic records..."
#       puts
#
#       result = record_type_class.bulk_import(
#         unimarc_records.to_a,
#         batch_size: batch_size,
#         batch_progress: progress_callback,
#         recursive: true
#       )
#
#       total = num_records - result.failed_instances.count
#     end
#
#     puts "#{total} records imported in #{time.real} seconds"
#   end
#
#   unimarc_auth_files.each do |unimarc_file|
#     total = nil
#
#     time = Benchmark.measure do
#       unimarc_records, record_type_class = Catalog::MARC::Record.read(unimarc_file, format: "unimarc", autosave: true, record_type: :authority)
#       num_records     = unimarc_records.count
#
#       puts "Importing #{num_records} UNIMARC authority records..."
#       puts
#
#       result = record_type_class.bulk_import(
#         unimarc_records.to_a,
#         batch_size: batch_size,
#         batch_progress: progress_callback,
#         recursive: true
#       )
#
#       total = num_records - result.failed_instances.count
#     end
#
#     puts "#{total} records imported in #{time.real} seconds"
#   end
# end

# puts "Total time (in secs): #{total_time.real}"
