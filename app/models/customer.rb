class Customer < ActiveRecord::Base
  has_many :invoices
  # has_many :transactions, through: :invoices

  def self.random
    random_id = Customer.pluck(:id).sample
    Customer.find(random_id)
  end

  def transactions
    self.invoices.map { |invoice| invoice.transactions }.flatten
  end

  def favorite_merchant
    # returns a merchant where the customer has conducted the most successful transactions
    
  end
end
