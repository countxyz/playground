require 'rails_helper'

RSpec.describe FaxPhone do

  describe 'Lengths' do
    it do
      is_expected.to validate_length_of(:phone_number).
      is_at_least(10).is_at_most(20)
    end
  end
end
