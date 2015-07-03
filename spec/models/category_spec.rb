require 'rails_helper'

RSpec.describe Category do

  describe 'Associations' do
    it { is_expected.to have_many :products }
  end

  describe 'Lengths' do
    it { is_expected.to validate_length_of(:name).is_at_most 50 }
  end

  describe 'Presence' do
    it { is_expected.to validate_presence_of :name }
  end

  describe 'Uniqueness' do
    subject { build :category                                               }
    it      { is_expected.to validate_uniqueness_of(:name).case_insensitive }
  end

  describe 'callbacks' do
    it "ensures 'name' is downcased before save" do
      expect((create :category, name: 'A').name).to eq 'a'
    end
  end
end
