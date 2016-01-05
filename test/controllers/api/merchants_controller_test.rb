require "test_helper"

class Api::V1::MerchantsControllerTest < ActionController::TestCase
  test "returns index" do
    get :index, format: :json
  end

  test "returns individual merchant" do
    get :show, format: :json
  end
end
