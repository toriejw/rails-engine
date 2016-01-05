require 'test_helper'

class CustomerTest < ActiveSupport::TestCase
  test "it returns a random record" do
    random_customer = Customer.random

    assert_equal Customer, random_customer.class
  end
end
