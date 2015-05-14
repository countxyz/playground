require 'rails_helper'

RSpec.describe LineItem do

  describe 'Associations' do
    it { is_expected.to belong_to :product }
  end

  describe 'Format' do
    it do
      is_expected.to validate_numericality_of(:quantity).
      only_integer.
      is_greater_than 0
    end
  end

  describe 'Presence' do
    it { is_expected.to validate_presence_of :quantity }
  end
end
