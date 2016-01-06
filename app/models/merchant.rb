class Merchant < ActiveRecord::Base
  has_many :items
  has_many :invoices

  def self.most_revenue(quantity)
    merchants = Merchant.joins(invoices: :invoice_items)

    all_revenues = {}

    merchants.each do |merchant|
      revenue = 0

      merchant.invoices.each do |invoice|
        invoice.invoice_items.each do |item|
          revenue += (item.quantity * item.unit_price.to_f)
        end
      end

      all_revenues[merchant.id] = revenue
    end

    top_merchants = []
    quantity.times do
      top_merchant_id = all_revenues.max_by { |k, v| v }[0]
      top_merchants << Merchant.find(top_merchant_id)

      all_revenues.delete(top_merchant_id)
    end

    top_merchants
  end
end
