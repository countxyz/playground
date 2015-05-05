class HomePhone < Phone

  validates_length_of :phone_number, is: 10
end
