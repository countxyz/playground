class LineItem < ActiveRecord::Base
  belongs_to :product

  validates_numericality_of :quantity, only_integer: true, greater_than: 0

  validates_presence_of :quantity
end
