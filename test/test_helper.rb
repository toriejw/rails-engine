require 'simplecov'
SimpleCov.start

ENV['RAILS_ENV'] ||= 'test'
require File.expand_path('../../config/environment', __FILE__)
require 'rails/test_help'
require 'minitest/pride'

module MerchantTestCase
  def create_merchants_with_invoices_and_invoice_items
    3.times do |i|
      merchant = Merchant.create(name: "merchant name #{i+1}")
      invoice_1 = Invoice.create(customer_id: 1, status: "success")
      invoice_2 = Invoice.create(customer_id: 1, status: "success")

      invoice_1.invoice_items << [ InvoiceItem.create(item_id: 1, quantity: 3+i, unit_price: "2.#{i}2"),
                                   InvoiceItem.create(item_id: 1, quantity: 2*(i+1), unit_price: "1.#{i}1") ]

      invoice_2.invoice_items << [ InvoiceItem.create(item_id: 1, quantity: 7+i, unit_price: "2.#{i}#{i}"),
                                   InvoiceItem.create(item_id: 1, quantity: 1*(i+1), unit_price: "#{i}.#{i}1") ]

      merchant.invoices << [ invoice_1, invoice_2 ]
    end
  end
end

module CustomerTestCase
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

class ActiveSupport::TestCase
  include MerchantTestCase
  include CustomerTestCase

  # Setup all fixtures in test/fixtures/*.yml for all tests in alphabetical order.
  fixtures :all

  # Add more helper methods to be used by all tests here...
end

class ActionController::TestCase
  include MerchantTestCase

  def parsed_response
    JSON.parse(response.body)
  end
end
