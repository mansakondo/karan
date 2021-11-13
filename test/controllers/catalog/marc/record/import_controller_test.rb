require "test_helper"

class Catalog::MARC::Record::ImportControllerTest < ActionDispatch::IntegrationTest
  test "should get new" do
    get catalog_marc_record_import_new_url
    assert_response :success
  end

  test "should get create" do
    get catalog_marc_record_import_create_url
    assert_response :success
  end
end
