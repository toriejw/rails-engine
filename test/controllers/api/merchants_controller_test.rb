require "test_helper"

class Api::V1::MerchantsControllerTest < ActionController::TestCase
  test "returns index" do
    get :index, format: :json
  end
end
