require 'rails_helper'

RSpec.describe Product do

  describe 'Associations' do
    it { is_expected.to belong_to :user }

    it { is_expected.to have_many(:line_items).dependent :destroy }
  end

  describe 'Format' do
    it do
      is_expected.to validate_numericality_of(:price).
      is_greater_than_or_equal_to 0.01
    end
  end

  describe 'Length' do
    it do
      is_expected.to validate_length_of(:title).
      is_at_least(2).is_at_most 50
    end
  end

  describe 'Presence' do
    it { is_expected.to validate_presence_of :title }
    it { is_expected.to validate_presence_of :price }
  end

  describe 'Retrieving Objects' do

    it 'finds product seller email' do
      user = create :user, email: 'aa@a.aa'
      expect(create(:product, user: user).seller_email).to eq 'aa@a.aa'
    end

    it 'counts all seller transactions' do
      expect(create(:product_line_items).sales_total).to eq 2
    end

    it 'calculates product quantity sales' do
      user, product = create(:user), create(:product)
      line_item     = create :line_item, quantity: 2, product: product
      expect(product.items_total).to eq 2
    end
  end
end
