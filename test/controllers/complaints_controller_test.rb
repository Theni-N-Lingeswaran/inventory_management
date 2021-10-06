require "test_helper"

class ComplaintsControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get complaints_index_url
    assert_response :success
  end
end
