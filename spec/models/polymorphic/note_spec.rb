require 'rails_helper'

RSpec.describe Note do

  describe 'Associations' do
    it { is_expected.to belong_to :noteable }
  end

  describe 'Lengths' do
    it { is_expected.to validate_length_of(:note).is_at_most 1000 }
  end

  describe 'Presence' do
    it { is_expected.to validate_presence_of :note }
  end
end
