require "test_helper"

class MARC::RecordsControllerTest < ActionDispatch::IntegrationTest
  test "should get show" do
    get marc_records_show_url
    assert_response :success
  end

  test "should get edit" do
    get marc_records_edit_url
    assert_response :success
  end

  test "should get update" do
    get marc_records_update_url
    assert_response :success
  end
end
