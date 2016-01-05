class Customer < ActiveRecord::Base
  def self.random
    random_id = Customer.pluck(:id).sample
    Customer.find(random_id)
  end
end
