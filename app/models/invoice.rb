class Invoice < ActiveRecord::Base
  belongs_to :merchant
  has_many :transactions
end
