class Merchant < ActiveRecord::Base
  has_many :items
  has_many :invoices

  def favorite_customer
    customer_count = self.invoices
                         .where(status: "shipped")
                         .group(:customer_id)
                         .count

    customer_id = customer_count.max_by { |k,v| v }[0]
    Customer.find(customer_id)
  end

  def total_revenue
    self.invoices
        .joins(:transactions)
        .successful
        .joins(:invoice_items)
        .where(status: "shipped")
        .sum("quantity * unit_price")
  end

  def revenue
    { "revenue" => total_revenue }
  end

  def revenue_for(date)
    ar_date = Time.zone.parse(date)
    revenue = self.invoices
                  .joins(:transactions)
                  .successful
                  .joins(:invoice_items)
                  .where(status: "shipped")
                  .where(created_at: ar_date)
                  .sum("quantity * unit_price")

    { "revenue" => revenue }
  end

  def self.most_revenue(quantity)
    all_revenues = {}
    Merchant.find_each do |merchant|
      all_revenues[merchant.id] = merchant.total_revenue
    end

    return_top_merchants(all_revenues, quantity)
  end

  def self.return_top_merchants(revenues, quantity)
    top_merchants = []
    quantity.to_i.times do
      top_id = all_revenues.max_by { |k, v| v }[0]
      top_merchants << Merchant.find(top_id)

      all_revenues.delete(top_id)
    end
    
    top_merchants
  end

  def self.most_items(quantity)

  end
end
