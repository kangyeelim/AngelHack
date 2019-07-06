require 'test_helper'

class ScreenerControllerTest < ActionDispatch::IntegrationTest
  test "should get strategies" do
    get screener_strategies_url
    assert_response :success
  end

  test "should get companies" do
    get screener_companies_url
    assert_response :success
  end

  test "should get indicators" do
    get screener_indicators_url
    assert_response :success
  end

end
