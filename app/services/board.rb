class Board
  attr_reader :stats

  SALES_TOTALS = { transactions: :update_transactions, items: :update_items }

  def initialize title, entries, category
    @entries     = entries
    @leaderboard = Leaderboard.new title
    @stats       = {}
    send SALES_TOTALS[category]
  end

  def update_transactions
    @entries.each do |entry|
      puts entry
      @leaderboard.rank_member entry.seller_email, entry.sales_total
    end
  end

  def update_items
    @entries.each do |entry|
      @leaderboard.rank_member entry.seller_email, entry.items_total
    end
  end

  def leader_pages total_pages
    @leaderboard.leaders total_pages
  end

  def user_performance email
    @stats = @leaderboard.score_and_rank_for email
    @stats.merge( { percentile: @leaderboard.percentile_for(email) } )
  end
end
