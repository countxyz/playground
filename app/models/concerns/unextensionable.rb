module Unextensionable
  extend ActiveSupport::Concern

  included do
    validates_length_of :phone_number, is: 10
  end
end
