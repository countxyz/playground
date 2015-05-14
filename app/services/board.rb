class Board

  def initialize title, entries
    @entries     = entries
    @leaderboard = Leaderboard.new title
  end

  def most_transactions total_pages
    update_sales
    leader_pages total_pages
  end

  def update_sales
    @entries.each do |entry|
      @leaderboard.rank_member entry.seller_email, entry.sales_total
    end
  end

  def leader_pages total_pages
    @leaderboard.leaders total_pages
  end
end
