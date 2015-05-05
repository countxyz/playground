require 'rails_helper'

RSpec.describe HomePhone do

  describe 'Lengths' do
    it { is_expected.to validate_length_of(:phone_number).is_equal_to 10 }
  end
end
