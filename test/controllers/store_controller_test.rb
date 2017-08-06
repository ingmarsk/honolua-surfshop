require 'test_helper'

class StoreControllerTest < ActionController::TestCase

	# Assertions are based on the test data from Fixtures
  test "should get index" do
    get :index
    assert_response :success
    assert_select 'h3', 'SexWax'
    assert_select 'h4 span', /\$[,\d]+\.\d\d/
  end

end
