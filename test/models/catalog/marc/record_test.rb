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
    assert @record.at("099").repeated? "a"
  end

  test "should decode raw MARC data" do
    results = @conn.search '@attr 1=4 "Sherlock Holmes"'
    marc    = results[0].raw
    record  = Catalog::MARC::Record.new_from_marc(marc)

    assert record
  end

  test "should resolve accessors according the record format" do
    marc21_record  = @record
    unimarc_record = Catalog::MARC::Record.last

    assert marc21_record.title
    assert unimarc_record.title
  end
end
