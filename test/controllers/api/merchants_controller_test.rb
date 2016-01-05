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

  test "#find returns invidual record when searched by name" do
    name = Merchant.first.name
    get :find, format: :json, name: name

    assert_response :success
    assert_kind_of Hash, parsed_response
    assert_equal name, parsed_response["name"]
  end

  test "#find_all returns array of all records matching search parameter for name" do
    customer_name = Merchant.first.name
    get :find_all, format: :json, name: customer_name

    assert_response :success
    assert_kind_of Array, parsed_response
    assert_equal Merchant.where(name: customer_name).count, parsed_response.count

    check_response_array_for_correct_data
  end

  test "#random returns individual record" do
    get :random, format: :json

    assert_response :success
    assert_kind_of Hash, parsed_response

    check_response_hash_for_correct_data
  end

  test "#merchant_items returns array of all items associated with a merchant" do
    create_merchant_with_items
    merchant = Merchant.last

    get :merchant_items, format: :json, id: merchant.id

    assert_response :success
    assert_kind_of Array, parsed_response
    assert_equal merchant.items.count, parsed_response.count
    binding.pry

    parsed_response.each do |record|
      assert record["name"]
      assert record["description"]
      assert record["unit_price"]
      assert_equal merchant.id, record["merchant_id"]
    end
  end

  test "" do
    # GET /api/v1/merchants/:id/invoices returns a collection of
    # invoices associated with that merchant from their known orders
  end

  def create_merchant_with_items
    Merchant.create(name: "merchant name")
    Merchant.last.items << [ Item.create(name: "item name", description: "item description", unit_price: "23.22"),
                             Item.create(name: "item name", description: "item description", unit_price: "21.22") ]
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
