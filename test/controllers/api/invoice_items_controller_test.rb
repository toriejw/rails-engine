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

  test "#find returns invidual record when searched by invoice_id" do
    invoice_id = InvoiceItem.first.invoice_id
    get :find, format: :json, invoice_id: invoice_id

    assert_response :success
    assert_kind_of Hash, parsed_response
    assert_equal invoice_id, parsed_response["invoice_id"]
  end

  test "#find returns invidual record when searched by item_id" do
    item_id = InvoiceItem.first.item_id
    get :find, format: :json, item_id: item_id

    assert_response :success
    assert_kind_of Hash, parsed_response
    assert_equal item_id, parsed_response["item_id"]
  end

  test "#find returns invidual record when searched by unit_price" do
    unit_price = InvoiceItem.first.unit_price
    get :find, format: :json, unit_price: unit_price

    assert_response :success
    assert_kind_of Hash, parsed_response
    assert_equal unit_price.to_s, parsed_response["unit_price"]
  end

  test "#find returns invidual record when searched by quantity" do
    quantity = InvoiceItem.first.quantity
    get :find, format: :json, quantity: quantity

    assert_response :success
    assert_kind_of Hash, parsed_response
    assert_equal quantity, parsed_response["quantity"]
  end

  test "#find_all returns array of all records matching search parameter for invoice_id" do
    customer_invoice_id = InvoiceItem.first.invoice_id
    get :find_all, format: :json, invoice_id: customer_invoice_id

    assert_response :success
    assert_kind_of Array, parsed_response
    assert_equal InvoiceItem.where(invoice_id: customer_invoice_id).count, parsed_response.count

    check_response_array_for_correct_data
  end

  test "#find_all returns array of all records matching search parameter for item_id" do
    customer_item_id = InvoiceItem.first.item_id
    get :find_all, format: :json, item_id: customer_item_id

    assert_response :success
    assert_kind_of Array, parsed_response
    assert_equal InvoiceItem.where(item_id: customer_item_id).count, parsed_response.count

    check_response_array_for_correct_data
  end

  test "#find_all returns array of all records matching search parameter for unit_price" do
    customer_unit_price = InvoiceItem.first.unit_price
    get :find_all, format: :json, unit_price: customer_unit_price

    assert_response :success
    assert_kind_of Array, parsed_response
    assert_equal InvoiceItem.where(unit_price: customer_unit_price).count, parsed_response.count

    check_response_array_for_correct_data
  end

  test "#find_all returns array of all records matching search parameter for quantity" do
    customer_quantity = InvoiceItem.first.quantity
    get :find_all, format: :json, quantity: customer_quantity

    assert_response :success
    assert_kind_of Array, parsed_response
    assert_equal InvoiceItem.where(quantity: customer_quantity).count, parsed_response.count

    check_response_array_for_correct_data
  end

  test "#random returns individual record" do
    get :random, format: :json

    assert_response :success
    assert_kind_of Hash, parsed_response

    check_response_hash_for_correct_data
  end

  test "#invoice_items_invoice returns associated invoice" do
    invoice_item = create_invoice_item_and_invoice

    get :invoice_items_invoice, format: :json, id: invoice_item.id

    assert_response :success
    assert_kind_of Hash, parsed_response

    assert parsed_response["customer_id"]
    assert parsed_response["merchant_id"]
    assert parsed_response["status"]
  end

  test "#invoice_items_item returns associated item" do
    invoice_item = create_invoice_item_and_item

    get :invoice_items_item, format: :json, id: invoice_item.id

    assert_response :success
    assert_kind_of Hash, parsed_response

    assert parsed_response["name"]
    assert parsed_response["merchant_id"]
    assert parsed_response["description"]
    assert parsed_response["unit_price"]
  end

  def create_invoice_item_and_invoice
    invoice = Invoice.create(customer_id: 1, merchant_id: 1, status: "success")
    InvoiceItem.create(item_id: 1, invoice_id: invoice.id, quantity: 1, unit_price: "1.11")
  end

  def create_invoice_item_and_item
    item = Item.create(name: "item name", description: "item description", unit_price: "1.11", merchant_id: 1)
    InvoiceItem.create(item_id: item.id, invoice_id: 1, quantity: 1, unit_price: "1.11")
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
