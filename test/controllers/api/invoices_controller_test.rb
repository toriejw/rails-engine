require "test_helper"

class Api::V1::InvoicesControllerTest < ActionController::TestCase
  test "#index returns array of all records" do
    get :index, format: :json

    assert_response :success
    assert_kind_of Array, parsed_response
    assert_equal Invoice.count, parsed_response.count

    check_response_array_for_correct_data
  end

  test "#show returns individual record" do
    invoice_id = Invoice.first.id
    get :show, format: :json, id: invoice_id

    assert_response :success
    assert_kind_of Hash, parsed_response

    assert parsed_response["customer_id"]
    assert parsed_response["merchant_id"]
    assert parsed_response["status"]
    assert_equal invoice_id, parsed_response["id"]
  end


  test "#random returns individual record" do
    get :random, format: :json

    assert_response :success
    assert_kind_of Hash, parsed_response

    check_response_hash_for_correct_data
  end

  def check_response_hash_for_correct_data
    assert parsed_response["customer_id"]
    assert parsed_response["merchant_id"]
    assert parsed_response["status"]
    assert parsed_response["id"]
  end

  def check_response_array_for_correct_data
    parsed_response.each do |record|
      assert record["customer_id"]
      assert record["merchant_id"]
      assert record["status"]
    end
  end
end
