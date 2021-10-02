# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: "Star Wars" }, { name: "Lord of the Rings" }])
#   Character.create(name: "Luke", movie: movies.first)
MARC::Record.create leader: "00815nam 2200289 a 4500", fields: [
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
]
