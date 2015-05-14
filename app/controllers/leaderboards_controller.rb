class LeaderboardsController < ApplicationController

  def show
    @most_sales = Board.new 'Most Sales', Product.all
    @entries    = @most_sales.most_transactions 1

    respond_to do |format|
      format.html
      format.json { render json: @entries }
    end
  end
end
