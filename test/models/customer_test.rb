require 'test_helper'

class CustomerTest < ActiveSupport::TestCase
  test "it returns a customer's favorite merchant" do
    create_customer_with_favorite_merchant

    favorite_merchant = Customer.last.favorite_merchant

    assert_equal "fave merchant", favorite_merchant.name
  end
end
