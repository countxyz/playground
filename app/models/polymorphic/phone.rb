class Phone < ActiveRecord::Base
  belongs_to :phoneable, polymorphic: true

  PHONE_TYPES = %w( FaxPhone HomePhone MobilePhone OfficePhone TollPhone )

  validates_inclusion_of :type, in: PHONE_TYPES

  validates_numericality_of :phone_number, only_integer: true
end
