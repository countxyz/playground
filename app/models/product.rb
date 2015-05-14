class Product < ActiveRecord::Base
  belongs_to :user

  has_many :line_items, dependent: :destroy

  validates_length_of :title, in: 2..50

  validates_numericality_of :price, greater_than_or_equal_to: 0.01

  validates_presence_of :title, :price

  def seller_email
    user.email
  end

  def sales_total
    line_items.count
  end

  def items_total
    line_items.sum :quantity
  end
end
