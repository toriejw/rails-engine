require "test_helper"

class Api::V1::ItemsControllerTest < ActionController::TestCase
  test "#index returns array of all records" do
    get :index, format: :json

    assert_response :success
    assert_kind_of Array, parsed_response
    assert_equal Item.count, parsed_response.count

    check_response_array_for_correct_data
  end

  test "#show returns individual record" do
    item_id = Item.first.id
    get :show, format: :json, id: item_id

    assert_response :success
    assert_kind_of Hash, parsed_response

    assert parsed_response["name"]
    assert parsed_response["description"]
    assert parsed_response["merchant_id"]
    assert parsed_response["unit_price"]
    assert_equal item_id, parsed_response["id"]
  end


  test "#random returns individual record" do
    get :random, format: :json

    assert_response :success
    assert_kind_of Hash, parsed_response

    check_response_hash_for_correct_data
  end

  def check_response_hash_for_correct_data
    assert parsed_response["name"]
    assert parsed_response["description"]
    assert parsed_response["merchant_id"]
    assert parsed_response["unit_price"]
    assert parsed_response["id"]
  end

  def check_response_array_for_correct_data
    parsed_response.each do |record|
      assert record["name"]
      assert record["description"]
      assert record["merchant_id"]
      assert record["unit_price"]
    end
  end
end
