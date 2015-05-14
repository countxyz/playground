require 'rails_helper'
require 'leaderboard'

RSpec.describe 'Boards Service' do

  describe 'Most Transactions' do
    it 'ranks users total transactions' do
      @users = [create(:user, email: 'a@aa.aa'), create(:user, email: 'b@bb.bb')]

      @products = [
        create(:product, user: @users.first),
        create(:product, user: @users.last)
      ]

      @line_items = [
        create(:line_item, product: @products.first),
        create(:line_item, product: @products.first),
        create(:line_item, product: @products.last),
      ]

      @most_sales = Board.new 'Most Sales Spec', @products
      @entries    = @most_sales.most_transactions 1

      expect(@entries).to eq [
        { member: 'a@aa.aa', rank: 1, score: 2.0 },
        { member: 'b@bb.bb', rank: 2, score: 1.0 }
      ]

      after_spec = Leaderboard.new('Most Sales Spec')
      after_spec.delete_leaderboard
    end
  end
end
