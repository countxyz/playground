require 'rails_helper'

RSpec.describe SeedHelper do

  describe 'Samples and randomness' do
    it 'samples booleans' do
      expect(helper.boolean_sample).to satisfy { |b| b == true || b == false }
    end

    it 'samples dates within the last two years' do
      expect(helper.datetime_sample).to be_between(2.years.ago, DateTime.now)
    end

    it 'creates random string composed of nine digit number' do
      expect(helper.random_phone_number).
      to be_between '1111111111', '9999999999'
    end
  end
end
