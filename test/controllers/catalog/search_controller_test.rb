require "test_helper"

class Catalog::SearchControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get catalog_search_index_url
    assert_response :success
  end
end
