require 'test_helper'

class SiteControllerTest < ActionController::TestCase

  %w{index bad_browsers best_practices form_ok form_error prices privacy signup spam terms tour}.each do |action|
    test "should get #{action}" do
      get action
      assert_response :success
    end
  end

end
