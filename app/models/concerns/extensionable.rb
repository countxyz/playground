module Extensionable
  extend ActiveSupport::Concern

  included do
    validates_length_of :phone_number, in: 10..20
  end
end
