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

  test "#find returns invidual record when searched by name" do
    name = Item.first.name
    get :find, format: :json, name: name

    assert_response :success
    assert_kind_of Hash, parsed_response
    assert_equal name, parsed_response["name"]
  end

  test "#find returns invidual record when searched by description" do
    description = Item.first.description
    get :find, format: :json, description: description

    assert_response :success
    assert_kind_of Hash, parsed_response
    assert_equal description, parsed_response["description"]
  end

  test "#find returns invidual record when searched by unit_price" do
    unit_price = Item.first.unit_price
    get :find, format: :json, unit_price: unit_price

    assert_response :success
    assert_kind_of Hash, parsed_response
    assert_equal unit_price, parsed_response["unit_price"]
  end

  test "#find returns invidual record when searched by merchant_id" do
    merchant_id = Item.first.merchant_id
    get :find, format: :json, merchant_id: merchant_id

    assert_response :success
    assert_kind_of Hash, parsed_response
    assert_equal merchant_id, parsed_response["merchant_id"]
  end

  test "#find_all returns array of all records matching search parameter for name" do
    customer_name = Item.first.name
    get :find_all, format: :json, name: customer_name

    assert_response :success
    assert_kind_of Array, parsed_response
    assert_equal Item.where(name: customer_name).count, parsed_response.count

    check_response_array_for_correct_data
  end

  test "#find_all returns array of all records matching search parameter for description" do
    customer_description = Item.first.description
    get :find_all, format: :json, description: customer_description

    assert_response :success
    assert_kind_of Array, parsed_response
    assert_equal Item.where(description: customer_description).count, parsed_response.count

    check_response_array_for_correct_data
  end

  test "#find_all returns array of all records matching search parameter for unit_price" do
    customer_unit_price = Item.first.unit_price
    get :find_all, format: :json, unit_price: customer_unit_price

    assert_response :success
    assert_kind_of Array, parsed_response
    assert_equal Item.where(unit_price: customer_unit_price).count, parsed_response.count

    check_response_array_for_correct_data
  end

  test "#find_all returns array of all records matching search parameter for merchant_id" do
    customer_merchant_id = Item.first.merchant_id
    get :find_all, format: :json, merchant_id: customer_merchant_id

    assert_response :success
    assert_kind_of Array, parsed_response
    assert_equal Item.where(merchant_id: customer_merchant_id).count, parsed_response.count

    check_response_array_for_correct_data
  end

  test "#random returns individual record" do
    get :random, format: :json

    assert_response :success
    assert_kind_of Hash, parsed_response

    check_response_hash_for_correct_data
  end

  test "#items_invoice_items" do
    item = create_item_and_invoice_items

    get :items_invoice_items, format: :json, id: item.id

    assert_response :success
    assert_kind_of Array, parsed_response
    assert_equal item.invoice_items.count, parsed_response.count

    parsed_response.each do |record|
      assert record["invoice_id"]
      assert record["quantity"]
      assert record["unit_price"]
      assert_equal item.id, record["item_id"]
    end
  end

  test "#items_merchant" do
    item = create_item_and_merchant

    get :items_merchant, format: :json, id: item.id

    assert_response :success
    assert_kind_of Hash, parsed_response

    assert parsed_response["name"]
  end

  def create_item
    Item.create(name: "item name", description: "item description", unit_price: "2.22", merchant_id: 1)
  end

  def create_item_and_invoice_items
    item = create_item
    item.invoice_items << [ InvoiceItem.create(invoice_id: 1, quantity: 1, unit_price: "2.22"),
                            InvoiceItem.create(invoice_id: 1, quantity: 1, unit_price: "1.11") ]
    item
  end

  def create_item_and_merchant
    merchant = Merchant.create(name: "name")
    Item.create(name: "item name", description: "item description", unit_price: "2.22", merchant_id: merchant.id)
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
