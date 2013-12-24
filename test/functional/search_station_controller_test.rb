require 'test_helper'

class SearchStationControllerTest < ActionController::TestCase
  test "should get index" do
    get :index
    assert_response :success
  end

  test "should get Search" do
    get :Search
    assert_response :success
  end

end
