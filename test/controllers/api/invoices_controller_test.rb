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

  test "#invoice_transactions returns array of transactions for an invoice" do
    invoice = create_invoice_and_transactions

    get :invoice_transactions, format: :json, id: invoice.id

    assert_response :success
    assert_kind_of Array, parsed_response
    assert_equal invoice.transactions.count, parsed_response.count

    parsed_response.each do |record|
      assert record["credit_card_number"]
      assert record["result"]
      assert_equal invoice.id, record["invoice_id"]
    end
  end

  test "#invoice_invoice_items returns array of invoice items for an invoice" do
    invoice = create_invoice_and_invoice_items

    get :invoice_invoice_items, format: :json, id: invoice.id

    assert_response :success
    assert_kind_of Array, parsed_response
    assert_equal invoice.invoice_items.count, parsed_response.count

    parsed_response.each do |record|
      assert record["item_id"]
      assert record["quantity"]
      assert record["unit_price"]
      assert_equal invoice.id, record["invoice_id"]
    end
  end

  test "#invoice_items returns array of items for an invoice" do
    # GET /api/v1/invoices/:id/items returns a collection of associated items
    invoice = create_invoice_and_items

    get :invoice_items, format: :json, id: invoice.id

    assert_response :success
    assert_kind_of Array, parsed_response
    assert_equal invoice.items.count, parsed_response.count

    parsed_response.each do |record|
      assert record["name"]
      assert record["description"]
      assert record["unit_price"]
      assert record["merchant_id"]
    end
  end

  test "#invoice_customer returns the customer for an invoice" do
    invoice = create_invoice_and_customer

    get :invoice_customer, format: :json, id: invoice.id

    assert_response :success
    assert_kind_of Hash, parsed_response

    assert parsed_response["first_name"]
    assert parsed_response["last_name"]
  end

  test "#invoice_merchant returns the merchant for an invoices" do
    invoice = create_invoice_and_merchant

    get :invoice_merchant, format: :json, id: invoice.id

    assert_response :success
    assert_kind_of Hash, parsed_response

    assert parsed_response["name"]
  end

  def create_invoice
    Invoice.create(customer_id: 1, merchant_id: 1, status: "success")
  end

  def create_invoice_and_transactions
    invoice = create_invoice
    invoice.transactions << [ Transaction.create(credit_card_number: "1234", result: "success"),
                              Transaction.create(credit_card_number: "1234", result: "failed") ]
    invoice
  end

  def create_invoice_and_invoice_items
    invoice = create_invoice
    invoice.invoice_items << [ InvoiceItem.create(item_id: 1, quantity: 1, unit_price: "2.22"),
                               InvoiceItem.create(item_id: 1, quantity: 1, unit_price: "1.11") ]
    invoice
  end

  def create_invoice_and_items
    invoice = create_invoice
    invoice.items << [ Item.create(merchant_id: 1, name: "item name", description: "item description", unit_price: "2.22"),
                       Item.create(merchant_id: 1, name: "item name", description: "item description", unit_price: "1.11") ]
    invoice
  end

  def create_invoice_and_customer
    customer = Customer.create(first_name: "first name", last_name: "last name")
    Invoice.create(customer_id: customer.id, merchant_id: 1, status: "success")
  end

  def create_invoice_and_merchant
    merchant = Merchant.create(name: "merchant name")
    Invoice.create(customer_id: 1, merchant_id: merchant.id, status: "success")
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
