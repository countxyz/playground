class Order < ActiveRecord::Base
  belongs_to :user

  validates_numericality_of :total, greater_than_or_equal_to: 0.00

  enum status: %i(shopping paid invoiced shipped)

  default_scope { order(updated_at: :desc) }
end
