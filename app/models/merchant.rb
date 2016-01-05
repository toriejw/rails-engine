class Merchant < ActiveRecord::Base
  has_many :items
end
