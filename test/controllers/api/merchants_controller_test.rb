require "test_helper"

class Api::V1::MerchantsControllerTest < ActionController::TestCase
  test "#index returns array of all records" do
    get :index, format: :json

    assert_response :success
    assert_kind_of Array, parsed_response
    assert_equal Merchant.count, parsed_response.count

    check_response_array_for_correct_data
  end

  test "#show returns individual record" do
    merchant_id = Merchant.first.id
    get :show, format: :json, id: merchant_id

    assert_response :success
    assert_kind_of Hash, parsed_response

    assert parsed_response["name"]
    assert_equal merchant_id, parsed_response["id"]
  end


  test "#random returns individual record" do
    get :random, format: :json

    assert_response :success
    assert_kind_of Hash, parsed_response

    check_response_hash_for_correct_data
  end

  def check_response_hash_for_correct_data
    assert parsed_response["name"]
    assert parsed_response["id"]
  end

  def check_response_array_for_correct_data
    parsed_response.each do |record|
      assert record["name"]
    end
  end
end
