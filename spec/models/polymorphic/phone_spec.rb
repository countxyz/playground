require 'rails_helper'

RSpec.describe Phone do

  describe 'Associations' do
    it { is_expected.to belong_to :phoneable }
  end

  describe 'Inclusions' do
    it do
      is_expected.to validate_inclusion_of(:type).
      in_array %w( FaxPhone HomePhone MobilePhone OfficePhone TollPhone )
    end
  end

  describe 'Numericality' do
    it { is_expected.to validate_numericality_of(:phone_number).only_integer }
  end
end
