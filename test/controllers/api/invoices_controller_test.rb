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

  test "#find returns invidual record when searched by customer_id" do
    customer_id = Invoice.first.customer_id
    get :find, format: :json, customer_id: customer_id

    assert_response :success
    assert_kind_of Hash, parsed_response
    assert_equal customer_id, parsed_response["customer_id"]
  end

  test "#find returns invidual record when searched by merchant_id" do
    merchant_id = Invoice.first.merchant_id
    get :find, format: :json, merchant_id: merchant_id

    assert_response :success
    assert_kind_of Hash, parsed_response
    assert_equal merchant_id, parsed_response["merchant_id"]
  end

  test "#find returns invidual record when searched by status" do
    status = Invoice.first.status
    get :find, format: :json, status: status

    assert_response :success
    assert_kind_of Hash, parsed_response
    assert_equal status, parsed_response["status"]
  end

  test "#find_all returns array of all records matching search parameter for customer_id" do
    customer_customer_id = Invoice.first.customer_id
    get :find_all, format: :json, customer_id: customer_customer_id

    assert_response :success
    assert_kind_of Array, parsed_response
    assert_equal Invoice.where(customer_id: customer_customer_id).count, parsed_response.count

    check_response_array_for_correct_data
  end

  test "#find_all returns array of all records matching search parameter for merchant_id" do
    customer_merchant_id = Invoice.first.merchant_id
    get :find_all, format: :json, merchant_id: customer_merchant_id

    assert_response :success
    assert_kind_of Array, parsed_response
    assert_equal Invoice.where(merchant_id: customer_merchant_id).count, parsed_response.count

    check_response_array_for_correct_data
  end

  test "#find_all returns array of all records matching search parameter for status" do
    customer_status = Invoice.first.status
    get :find_all, format: :json, status: customer_status

    assert_response :success
    assert_kind_of Array, parsed_response
    assert_equal Invoice.where(status: customer_status).count, parsed_response.count

    check_response_array_for_correct_data
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
