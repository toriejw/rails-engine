require "test_helper"

class Api::V1::ItemsControllerTest < ActionController::TestCase
  test "returns index" do
    get :index, format: :json
  end

  test "returns individual item" do
    # get :show, format: :json
  end
end
