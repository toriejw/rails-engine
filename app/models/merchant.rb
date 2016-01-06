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
    all_revenues = []
    Merchant.find_each do |merchant|
      all_revenues << [merchant.id, merchant.total_revenue]
    end

    return_top_merchants_by_revenue(all_revenues, quantity)
  end

  def self.return_top_merchants_by_revenue(revenues, quantity)
    sorted_merchants_by_revenue = revenues.sort_by { |pair| pair[1] }.reverse

    top_merchants = []
    quantity.to_i.times do |i|
      top_merchants << Merchant.find(sorted_merchants_by_revenue[i][0])
    end

    top_merchants
  end

  def self.most_items(quantity)
    items_sold_count_by_merchant = []
    Merchant.find_each do |merchant|
      items_sold_count_by_merchant << [merchant.id, merchant.total_items_sold]
    end

    return_top_merchants_by_items_sold(items_sold_count_by_merchant, quantity)
  end

  def total_items_sold
    self.invoices
        .joins(:transactions)
        .successful
        .joins(:invoice_items)
        .sum(:quantity)
  end

  def self.return_top_merchants_by_items_sold(item_counts, quantity)
    sorted_merchants_by_item_count = item_counts.sort_by { |pair| pair[1] }.reverse

    top_merchants = []
    quantity.to_i.times do |i|
      top_merchants << Merchant.find(sorted_merchants_by_item_count[i][0])
    end

    top_merchants
  end

end
