require "test_helper"

class MARC::RecordTest < ActiveSupport::TestCase
  fixtures "marc/records"

  setup do
    @record = marc_records(:hamlet)
  end

  test "#repeated?" do
    assert @record.repeated? "948"
    assert @record["099"].repeated? "a"
  end
end
