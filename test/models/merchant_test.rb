require 'test_helper'

class MerchantTest < ActiveSupport::TestCase
  test "it returns merchants with the most revenue for quantity 2" do
    create_merchants_with_invoices_and_invoice_items

    merchants_with_most_revenue = Merchant.most_revenue(2)

    assert_equal 2, merchants_with_most_revenue.count

    assert_equal "merchant name 3", merchants_with_most_revenue.first["name"]
    assert_equal "merchant name 2", merchants_with_most_revenue.last["name"]
  end

  test "it returns merchants with the most revenue for quantity 1" do
    create_merchants_with_invoices_and_invoice_items

    merchants_with_most_revenue = Merchant.most_revenue(1)

    assert_equal 1, merchants_with_most_revenue.count

    assert_equal "merchant name 3", merchants_with_most_revenue.first["name"]
  end
end
