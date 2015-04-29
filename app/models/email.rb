class Email < ActiveRecord::Base
  belongs_to :emailable, polymorphic: true

  ADDRESS_REGEX = /\A[^@\s]+@([^@\s]+\.)+[^@\s]+\z/

  validates_format_of :address, with: ADDRESS_REGEX

  validates_length_of :address, in: 5..50
end
