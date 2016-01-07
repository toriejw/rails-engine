class Customer < ActiveRecord::Base
  has_many :invoices
  # has_many :transactions, through: :invoices

  def transactions
    self.invoices.map { |invoice| invoice.transactions }.flatten
  end

  def favorite_merchant
    merchant_count = self.invoices
                         .where(status: "shipped")
                         .group(:merchant_id)
                         .count

    merchant_id = merchant_count.max_by { |k, v| v }[0]

    Merchant.find(merchant_id)
  end
end
