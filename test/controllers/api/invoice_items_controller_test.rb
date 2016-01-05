require "test_helper"

class Api::V1::InvoiceItemsControllerTest < ActionController::TestCase
  test "#index returns array of all records" do
    get :index, format: :json

    assert_response :success
    assert_kind_of Array, parsed_response
    assert_equal InvoiceItem.count, parsed_response.count

    check_response_array_for_correct_data
  end

  test "#show returns individual record" do
    invoice_item_id = InvoiceItem.first.id
    get :show, format: :json, id: invoice_item_id

    assert_response :success
    assert_kind_of Hash, parsed_response

    assert parsed_response["invoice_id"]
    assert parsed_response["item_id"]
    assert parsed_response["unit_price"]
    assert parsed_response["quantity"]
    assert_equal invoice_item_id, parsed_response["id"]
  end

  # test "#find returns invidual record when searched by first_name" do
  #   customer_name = InvoiceItem.first.first_name
  #   get :find, format: :json, first_name: customer_name
  #
  #   assert_response :success
  #   assert_kind_of Hash, parsed_response
  #   assert_equal customer_name, parsed_response["first_name"]
  #
  #   assert parsed_response["last_name"]
  #   assert parsed_response["id"]
  # end
  #
  # test "#find returns invidual record when searched by last_name" do
  #   customer_name = Customer.first.last_name
  #   get :find, format: :json, last_name: customer_name
  #
  #   assert_response :success
  #   assert_kind_of Hash, parsed_response
  #   assert_equal customer_name, parsed_response["last_name"]
  #
  #   assert parsed_response["first_name"]
  #   assert parsed_response["id"]
  # end
  #
  # test "#find returns invidual record when searched by id" do
  #   customer_id = Customer.first.id
  #   get :find, format: :json, id: customer_id
  #
  #   assert_response :success
  #   assert_kind_of Hash, parsed_response
  #   assert_equal customer_id, parsed_response["id"]
  #
  #   assert parsed_response["first_name"]
  #   assert parsed_response["last_name"]
  # end
  #
  # test "#find returns invidual record when searched by created_at" do
  #   customer_created_at_date = Customer.first.created_at
  #   get :find, format: :json, created_at: customer_created_at_date
  #
  #   assert_response :success
  #   assert_kind_of Hash, parsed_response
  #   assert_equal customer_created_at_date, parsed_response["created_at"]
  #
  #   check_response_hash_for_correct_data
  # end
  #
  # test "#find returns invidual record when searched by updated_at" do
  #   customer_updated_at_date = Customer.first.updated_at
  #   get :find, format: :json, updated_at: customer_updated_at_date
  #
  #   assert_response :success
  #   assert_kind_of Hash, parsed_response
  #   assert_equal customer_updated_at_date, parsed_response["updated_at"]
  #
  #   check_response_hash_for_correct_data
  # end
  #
  # test "#find_all returns array of all records matching search parameter for first_name" do
  #   customer_first_name = Customer.first.first_name
  #   get :find_all, format: :json, first_name: customer_first_name
  #
  #   assert_response :success
  #   assert_kind_of Array, parsed_response
  #   assert_equal Customer.where(first_name: customer_first_name).count, parsed_response.count
  #
  #   check_response_array_for_correct_data
  # end
  #
  # test "#find_all returns array of all records matching search parameter for last_name" do
  #   customer_last_name = Customer.first.last_name
  #   get :find_all, format: :json, last_name: customer_last_name
  #
  #   assert_response :success
  #   assert_kind_of Array, parsed_response
  #   assert_equal Customer.where(last_name: customer_last_name).count, parsed_response.count
  #
  #   check_response_array_for_correct_data
  # end
  #
  # test "#find_all returns array of all records matching search parameter for id" do
  #   customer_id = Customer.first.id
  #   get :find_all, format: :json, id: customer_id
  #
  #   assert_response :success
  #   assert_kind_of Array, parsed_response
  #   assert_equal Customer.where(id: customer_id).count, parsed_response.count
  #
  #   check_response_array_for_correct_data
  # end
  #
  # test "#find_all returns array of all records matching search parameter for created_at" do
  #   customer_created_at = Customer.first.created_at
  #   get :find_all, format: :json, created_at: customer_created_at
  #
  #   assert_response :success
  #   assert_kind_of Array, parsed_response
  #   assert_equal Customer.where(created_at: customer_created_at).count, parsed_response.count
  #
  #   check_response_array_for_correct_data
  # end
  #
  # test "#find_all returns array of all records matching search parameter for updated_at" do
  #   customer_updated_at = Customer.first.updated_at
  #   get :find_all, format: :json, updated_at: customer_updated_at
  #
  #   assert_response :success
  #   assert_kind_of Array, parsed_response
  #   assert_equal Customer.where(updated_at: customer_updated_at).count, parsed_response.count
  #
  #   check_response_array_for_correct_data
  # end

  test "#random returns individual record" do
    get :random, format: :json

    assert_response :success
    assert_kind_of Hash, parsed_response

    check_response_hash_for_correct_data
  end

  def check_response_hash_for_correct_data
    assert parsed_response["item_id"]
    assert parsed_response["invoice_id"]
    assert parsed_response["quantity"]
    assert parsed_response["unit_price"]
    assert parsed_response["id"]
  end

  def check_response_array_for_correct_data
    parsed_response.each do |record|
      assert record["item_id"]
      assert record["invoice_id"]
      assert record["quantity"]
      assert record["unit_price"]
    end
  end
end
