require 'test_helper'

class CustomerControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get customer_index_url
    assert_response :success
  end

  test "should get new" do
    get customer_new_url
    assert_response :success
  end

  test "should get update" do
    get customer_update_url
    assert_response :success
  end

end
