require "test_helper"

class Api::V1::CustomersControllerTest < ActionController::TestCase
  test "returns index" do
    get :index, format: :json
  end

  test "returns individual customer" do
    get :show, format: :json
  end
end
