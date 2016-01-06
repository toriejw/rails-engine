require 'test_helper'

class InvoiceTest < ActiveSupport::TestCase
  test "it can return only invoices with successful transactions" do
    create_invoices_with_transactions
    successful_invoices = Invoice.successful

    assert_equal 1, successful_invoices.count
    assert_equal Invoice.first, successful_invoices.first
  end

  def create_invoices_with_transactions
    first_invoice = Invoice.first
    second_invoice = Invoice.last

    first_invoice.transactions << Transaction.create(result: "success")
    second_invoice.transactions << Transaction.create(result: "failed")
  end
end
