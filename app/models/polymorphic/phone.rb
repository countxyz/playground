class Phone < ActiveRecord::Base
  belongs_to :phoneable, polymorphic: true

  PHONE_TYPES = %w( FaxPhone HomePhone MobilePhone OfficePhone TollPhone )

  validates_inclusion_of :type, in: PHONE_TYPES

  validates_numericality_of :phone_number, only_integer: true
end

class FaxPhone < Phone
  validates_length_of :phone_number, in: 10..20
end

class HomePhone < Phone
  validates_length_of :phone_number, is: 10
end

class MobilePhone < Phone
  validates_length_of :phone_number, is: 10
end

class OfficePhone < Phone
  validates_length_of :phone_number, in: 10..20
end

class TollPhone < Phone
  validates_length_of :phone_number, is: 10
end
