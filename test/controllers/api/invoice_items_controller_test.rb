require "test_helper"

class Api::V1::InvoiceItemsControllerTest < ActionController::TestCase
  test "returns index" do
    get :index, format: :json
  end

  test "returns individual invoice item" do
    # get :show, format: :json
  end
end
