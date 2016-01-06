require 'test_helper'

class CustomerTest < ActiveSupport::TestCase
  test "it returns a random record" do
    random_customer = Customer.random

    assert_equal Customer, random_customer.class
  end

  test "it returns a customer's favorite merchant" do
    create_customer_with_favorite_merchant

    favorite_merchant = Customer.last.favorite_merchant

    assert_equal "fave merchant", favorite_merchant.name
  end

  def create_customer_with_favorite_merchant
    not_favorite_merchant = Merchant.create(name: "merchant name")
    favorite_merchant     = Merchant.create(name: "fave merchant")

    customer = Customer.create(first_name: "first name", last_name: "last name")

    first_invoice  = Invoice.create(merchant_id: favorite_merchant.id, status: "shipped")
    second_invoice = Invoice.create(merchant_id: favorite_merchant.id, status: "shipped")
    third_invoice  = Invoice.create(merchant_id: not_favorite_merchant.id, status: "shipped")

    first_invoice.transactions << Transaction.create(result: "success")
    second_invoice.transactions << Transaction.create(result: "success")

    customer.invoices << [first_invoice, second_invoice]
  end
end
