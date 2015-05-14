require 'rails_helper'
require 'leaderboard'

RSpec.describe 'Boards Service' do

  describe 'Most Transactions' do
    before do
      @users = [create(:user, email: 'a@aa.aa'), create(:user, email: 'b@bb.bb')]

      @products = [
        create(:product, user: @users.first),
        create(:product, user: @users.last)
      ]

      @line_items = [
        create(:line_item, quantity: 1, product: @products.first),
        create(:line_item, quantity: 2, product: @products.first),
        create(:line_item, quantity: 5, product: @products.last),
      ]
    end

    it 'ranks users total transactions' do
      @most_sales = Board.new 'Most Sales Spec', @products, :transactions
      @entries    = @most_sales.leader_pages 1

      expect(@entries).to eq [
        { member: 'a@aa.aa', rank: 1, score: 2.0 },
        { member: 'b@bb.bb', rank: 2, score: 1.0 }
      ]

      delete_leaderboard 'Most Sales Spec'
    end

    it 'ranks users total item sales' do
      @most_items = Board.new 'Most Items Spec', @products, :items
      @entries    = @most_items.leader_pages 1

      expect(@entries).to eq [
        { member: 'b@bb.bb', rank: 1, score: 5.0 },
        { member: 'a@aa.aa', rank: 2, score: 3.0 }
      ]

      delete_leaderboard 'Most Items Spec'
    end
  end
end
