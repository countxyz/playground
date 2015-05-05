class FaxPhone < Phone

  validates_length_of :phone_number, in: 10..20
end
