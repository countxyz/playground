class Phone < ActiveRecord::Base
  belongs_to :phoneable, polymorphic: true

  PHONE_TYPES = %w( fax home mobile office toll )

  validates_inclusion_of :type, in: PHONE_TYPES
end
