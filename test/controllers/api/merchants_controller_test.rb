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
    merchant = create_merchant_with_items

    get :merchant_items, format: :json, id: merchant.id

    assert_response :success
    assert_kind_of Array, parsed_response
    assert_equal merchant.items.count, parsed_response.count

    parsed_response.each do |record|
      assert record["name"]
      assert record["description"]
      assert record["unit_price"]
      assert_equal merchant.id, record["merchant_id"]
    end
  end

  test "#merchant_invoices returns array of all invoices associated with a merchant" do
    merchant = create_merchant_with_invoices

    get :merchant_invoices, format: :json, id: merchant.id

    assert_response :success
    assert_kind_of Array, parsed_response
    assert_equal merchant.invoices.count, parsed_response.count

    parsed_response.each do |record|
      assert record["customer_id"]
      assert record["status"]
      assert_equal merchant.id, record["merchant_id"]
    end
  end

  test "#most_revenue returns given number of merchants with the most revenue" do
    create_merchants_with_invoices_and_invoice_items

    get :most_revenue, format: :json, quantity: 2

    assert_response :success
    assert_kind_of Array, parsed_response
    assert_equal 2, parsed_response.count

    assert_equal "merchant name 3", parsed_response.first["name"]
    assert_equal "merchant name 2", parsed_response.last["name"]
  end

  test "#most_items returns given number of merchants with the most items sold" do
    create_merchants_with_invoices_and_invoice_items

    get :most_items, format: :json, quantity: 2

    assert_response :success
    assert_kind_of Array, parsed_response
    assert_equal 2, parsed_response.count

    assert_equal "merchant name 3", parsed_response.first["name"]
    assert_equal "merchant name 2", parsed_response.last["name"]
  end

  # test "#revenue" do
  #   skip
  #   # GET /api/v1/merchants/revenue?date=x returns the total revenue for date x across all merchants
  #
  # end

  # test "#favorite_customer returns customer with most successful transactions" do
  #   # GET /api/v1/merchants/:id/favorite_customer returns the customer who has conducted the most successful transactions
  #   # merchant = create_merchant_with_invoices_transactions_and_customers
  #
  #   get :favorite_customer, format: :json, id: Merchant.first.id
  #
  #   assert_response :success
  # end
  #
  # def create_merchant_with_invoices_transactions_and_customers
  #
  # end

  def create_merchant_with_items
    merchant = Merchant.create(name: "merchant name")
    merchant.items << [ Item.create(name: "item name", description: "item description", unit_price: "23.22"),
                        Item.create(name: "item name", description: "item description", unit_price: "21.22") ]
    merchant
  end

  def create_merchant_with_invoices
    merchant = Merchant.create(name: "merchant name")
    merchant.invoices << [ Invoice.create(customer_id: 1, status: "success"),
                           Invoice.create(customer_id: 1, status: "success") ]
    merchant
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
