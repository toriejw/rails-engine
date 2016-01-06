class Invoice < ActiveRecord::Base
  belongs_to :merchant
  has_many :transactions
  has_many :invoice_items
end
