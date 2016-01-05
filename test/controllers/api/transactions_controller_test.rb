require "test_helper"

class Api::V1::TransactionsControllerTest < ActionController::TestCase
  test "#index returns array of all records" do
    get :index, format: :json

    assert_response :success
    assert_kind_of Array, parsed_response
    assert_equal Transaction.count, parsed_response.count

    check_response_array_for_correct_data
  end

  test "#show returns individual record" do
    transaction_id = Transaction.first.id
    get :show, format: :json, id: transaction_id

    assert_response :success
    assert_kind_of Hash, parsed_response

    assert parsed_response["invoice_id"]
    assert parsed_response["credit_card_number"]
    assert parsed_response["result"]
    assert_equal transaction_id, parsed_response["id"]
  end

  test "#find returns invidual record when searched by invoice_id" do
    invoice_id = Transaction.first.invoice_id
    get :find, format: :json, invoice_id: invoice_id

    assert_response :success
    assert_kind_of Hash, parsed_response
    assert_equal invoice_id, parsed_response["invoice_id"]
  end

  test "#find returns invidual record when searched by credit_card_number" do
    credit_card_number = Transaction.first.credit_card_number
    get :find, format: :json, credit_card_number: credit_card_number

    assert_response :success
    assert_kind_of Hash, parsed_response
    assert_equal credit_card_number, parsed_response["credit_card_number"]
  end

  test "#find returns invidual record when searched by result" do
    result = Transaction.first.result
    get :find, format: :json, result: result

    assert_response :success
    assert_kind_of Hash, parsed_response
    assert_equal result, parsed_response["result"]
  end

  test "#find_all returns array of all records matching search parameter for invoice_id" do
    customer_invoice_id = Transaction.first.invoice_id
    get :find_all, format: :json, invoice_id: customer_invoice_id

    assert_response :success
    assert_kind_of Array, parsed_response
    assert_equal Transaction.where(invoice_id: customer_invoice_id).count, parsed_response.count

    check_response_array_for_correct_data
  end

  test "#find_all returns array of all records matching search parameter for credit_card_number" do
    customer_credit_card_number = Transaction.first.credit_card_number
    get :find_all, format: :json, credit_card_number: customer_credit_card_number

    assert_response :success
    assert_kind_of Array, parsed_response
    assert_equal Transaction.where(credit_card_number: customer_credit_card_number).count, parsed_response.count

    check_response_array_for_correct_data
  end

  test "#find_all returns array of all records matching search parameter for result" do
    customer_result = Transaction.first.result
    get :find_all, format: :json, result: customer_result

    assert_response :success
    assert_kind_of Array, parsed_response
    assert_equal Transaction.where(result: customer_result).count, parsed_response.count

    check_response_array_for_correct_data
  end

  test "#random returns individual record" do
    get :random, format: :json

    assert_response :success
    assert_kind_of Hash, parsed_response

    check_response_hash_for_correct_data
  end

  def check_response_hash_for_correct_data
    assert parsed_response["invoice_id"]
    assert parsed_response["credit_card_number"]
    assert parsed_response["result"]
    assert parsed_response["id"]
  end

  def check_response_array_for_correct_data
    parsed_response.each do |record|
      assert record["invoice_id"]
      assert record["credit_card_number"]
      assert record["result"]
    end
  end
end
