class LeaderboardsController < ApplicationController

  def show
    build_sales
    build_items
  end

  private

  def build_sales
    @most_sales    = Board.new 'Most Sales', Product.all, :transactions
    @sales_entries = @most_sales.leader_pages 1
  end

  def build_items
    @most_items    = Board.new 'Most Items', Product.all, :items
    @item_entries  = @most_items.leader_pages 1
  end
end
