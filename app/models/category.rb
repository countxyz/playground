class Category < ActiveRecord::Base
  has_many :products

  validates_length_of :name, maximum: 50

  validates_presence_of :name

  validates_uniqueness_of :name, case_sensitive: false

  before_save :downcase_name

  private

  def downcase_name
    self.name = name.downcase
  end
end
