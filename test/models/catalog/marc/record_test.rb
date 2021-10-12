require "test_helper"

class Catalog::MARC::RecordTest < ActiveSupport::TestCase
  fixtures "catalog/marc/records"

  setup do
    @record = catalog_marc_records(:hamlet)
  end

  test "#repeated?" do
    assert @record.repeated? "948"
    assert @record["099"].repeated? "a"
  end
end
