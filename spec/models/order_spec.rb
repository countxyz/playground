require 'rails_helper'

RSpec.describe Order do

  describe 'associations' do
    it { is_expected.to belong_to(:user) }
  end

  describe 'status' do
    it do
      is_expected.to define_enum_for(:status).
      with(%i(shopping paid invoiced shipped))
    end
  end

  describe 'format' do
    it do
      is_expected.to validate_numericality_of(:total).
      is_greater_than_or_equal_to(0.00)
    end
  end

  describe 'default scope' do
    it 'returns orders in descending order by updated_at value' do
      older_order = create(:order, updated_at: 2.days.ago)
      newer_order = create(:order, updated_at: 1.day.ago)
      expect(Order.all).to eq [newer_order, older_order]
    end
  end

  describe 'default attributes' do
    it 'is 0.00 for total' do
      expect(create(:order).total).to eq 0.00
    end

    it 'is In Progress for status' do
      expect(create(:order).status.humanize).to eq 'Shopping'
    end
  end
end
