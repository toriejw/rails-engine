class Merchant < ActiveRecord::Base
  has_many :items
  has_many :invoices

  def favorite_customer
    customer_count = self.invoices.joins(:customer).where(status: "shipped").group(:customer_id).count
    customer_id = customer_count.max_by { |k,v| v }[0]

    Customer.find(customer_id)
  end

  def self.most_revenue(quantity)
    # # merchants = Merchant.joins(invoices: :invoice_items)
    # merchants = Merchant.all
    #
    # all_revenues = {}
    #
    # merchants.each do |merchant|
    #   revenue = 0
    #
    #   merchant.invoices.find_each do |invoice|
    #     invoice.invoice_items.find_each do |item|
    #       revenue += (item.quantity * item.unit_price.to_f)
    #     end
    #   end
    #
    #   all_revenues[merchant.id] = revenue
    # end
    #
    # # all_revenues = {}
    # # Merchant.find_each do |merchant|
    # #   all_revenues[merchant.id] = merchant.invoices.joins(:invoice_items).sum("quantity * unit_price")
    # # end
    #
    # top_merchants = []
    # quantity.times do
    #   top_merchant_id = all_revenues.max_by { |k, v| v }[0]
    #   top_merchants << Merchant.find(top_merchant_id)
    #
    #   all_revenues.delete(top_merchant_id)
    # end
    #
    # top_merchants
  end

  def self.most_items(quantity)

  end
end
