require "test_helper"

class Catalog::MARC::RecordTest < ActiveSupport::TestCase
  fixtures "catalog/marc/records"

  setup do
    @record = catalog_marc_records(:hamlet)

    @conn = ZOOM::Connection.new.connect("catalog.brooklynpubliclibrary.org:210")
    @conn.database_name = "innopac"
  end

  test "#repeated?" do
    assert @record.repeated? "948"
    assert @record["099"].repeated? "a"
  end

  test "should decode raw MARC data" do
    results = @conn.search '@attr 1=4 "Sherlock Holmes"'
    marc    = results[0].raw
    record  = Catalog::MARC::Record.new_from_marc(marc)

    assert record
  end
end
